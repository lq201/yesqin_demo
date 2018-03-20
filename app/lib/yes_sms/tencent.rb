# coding: utf-8
# 短信的发送
# example: YesSms::Tencent.send_validation_code(18918869490)
require 'open-uri'
require 'net/http'
require 'net/https'
require 'json'
require 'digest'

module YesSms
  class Tencent
    def self.send_validation_code(mobile)

      appid = "1400064423"
      appkey = "93ac5cfdc835c64b284f6c8b891e1339"
      random = 1234
      unix_timestamps = Time.now.to_i

      # test_sig = "appkey=5f03a35d00ee52a21327ab048186a2c4&random=7226249334&time=1457336869&mobile=13788888888"
      str_sig = "appkey=#{appkey}&random=#{random}&time=#{unix_timestamps}&mobile=#{mobile}"
      puts str_sig

      sig = Digest::SHA256.hexdigest(str_sig)
      puts sig

      sign = "悦勤信息"
      tpl_id = 79501
      params = ["5678", "3"]

      uri = URI.parse("https://yun.tim.qq.com/v5/tlssmssvr/sendsms?sdkappid=#{appid}&random=#{random}")

      puts uri

      header = {
        'Content-Type' => 'text/json',
        'charset' => 'utf-8'
      }

      body = {
        "tel" => {
          "nationcode" => "86",  
          "mobile" => mobile.to_s
        },
        "sign" => sign,
        "tpl_id" => tpl_id,
        "params" => params,
        "sig" => sig, 
        "time" => unix_timestamps,
        "extend" => "", 
        "ext" => ""        
      }

      puts body.inspect
      
      # Create the HTTP objects
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = body.to_json

      # Send the request
      res = https.request(request)
      
      puts "Response #{res.code} #{res.message}: #{res.body}"
    end
  end
end
