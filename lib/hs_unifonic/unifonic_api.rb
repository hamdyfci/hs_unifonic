module UnifonicApi
  DEFAULT_OPEN_TIMEOUT = 2
  DEFAULT_TIMEOUT = 5

  # using appsid to send sms
  def self.send_sms_rest(credentials, mobile_number, message, sender, options = {})
    # request config
    connection = Faraday.new(credentials[:server]) do |faraday|
      faraday.request :multipart
      faraday.request :url_encoded
      faraday.options[:open_timeout] = options[:open_timeout] || DEFAULT_OPEN_TIMEOUT
      faraday.options[:timeout] = options[:timeout] || DEFAULT_TIMEOUT
      faraday.adapter Faraday.default_adapter
    end
    mobile = mobile_number.gsub(/[^a-z,0-9]/, '')

    uri = URI('/rest/SMS/Messages/Send')
    app_sid = credentials[:appsid]
    msg = message.encode(Encoding::UTF_8)

    # request parameters
    params = {
      Recipient: mobile,
      Body: msg,
      AppSid: app_sid,
      SenderID: sender,
      Priority: 'High'
    }

    response = connection.post do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = params
    end

    if response.status.to_i.in?(200..299)
      response_body = JSON.parse(response.body)
      message_id = response_body['data']['MessageID']
      return { message_id: message_id, code: 0 }
    else
      return { error: response.body, code: response.status.to_i }
    end
  end

  def self.send_sms_wrapper(credentials, mobile_number, message, sender, options = {})
    connection = Faraday.new(credentials[:server]) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.options[:open_timeout] = options[:open_timeout] || DEFAULT_OPEN_TIMEOUT
      faraday.options[:timeout] = options[:timeout] || DEFAULT_TIMEOUT
    end
    appsid = credentials[:appsid]
    mobile = mobile_number.gsub(/[^a-z,0-9]/, '')
    uri = URI('/wrapper/sendSMS.php')
    params = { appsid: appsid, msg: message, to: mobile, sender: sender, format: 'json', messageBodyEncoding: 'UTF8', smscEncoding: 'UCS2' }
    response = connection.get do |req|
      req.url uri.path
      req.params = params
    end
    if response.status.to_i.in?(200..299)
      message_id = response.body.gsub(/\s+/, '').split(':').last
      return { message_id: message_id, code: 0 }
    else
      return { error: response.body, code: response.status.to_i }
    end
  end
end
