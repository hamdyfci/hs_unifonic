require "hs_unifonic/version"
require "hs_unifonic/unifonic_api"

module HsUnifonic
  
  def self.send_sms(credentials, mobile_number, message,sender,options = nil)
    return UnifonicApi.send_sms_by_appsid(credentials, mobile_number, message,sender,options)
  end

end