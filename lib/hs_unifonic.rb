require 'hs_unifonic/version'
require 'hs_unifonic/unifonic_api'

module HsUnifonic
  def self.send_sms(credentials, mobile_number, message, sender, options = nil)
    if credentials[:method].present? && credentials[:method] == 'rest'
      return UnifonicApi.send_sms_rest(credentials, mobile_number, message, sender, options)
    end

    return UnifonicApi.send_sms_wrapper(credentials, mobile_number, message, sender, options)
  end
end
