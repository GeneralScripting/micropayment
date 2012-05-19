module Micropayment

  module API

    extend self

    RootCA          = '/etc/ssl/certs'
    DEFAULT_TIMEOUT = 10

    def ensure_api_key!
      raise "Micropayment::Config.api_key has not been set. See github.com/GeneralScripting/micropayment"  unless Config.api_key
    end

    def call(url, method, data={})
      ensure_api_key!
      data[:action]     = method
      data[:accessKey]  = Config.api_key
      data[:testMode] ||= Config.sandbox || 0
      data.delete_if {|k,v| v.nil? }
      uri = Addressable::URI.parse(url)
      uri.query_values = data
      parseNVP get(uri)
    end

    def get(uri)
      use_ssl = uri.scheme == 'https'
      http = Net::HTTP.new(uri.host, use_ssl ? 443 : 80)
      http.use_ssl = use_ssl
      #http.read_timeout = timeout
      if use_ssl
        if File.directory? RootCA
          http.ca_path = RootCA
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.verify_depth = 5
        else
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end
      response = http.get uri.request_uri, 'User-agent' => 'Micropayment Ruby Client'
      case response
      when Net::HTTPSuccess, Net::HTTPOK
        response.body
      else
        response.error!
      end
    end

    def parseNVP(text)
      Addressable::URI.parse("http://example.com?#{text.split("\n").join("&")}").query_values
    end

  end

end