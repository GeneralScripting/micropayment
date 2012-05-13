module Micropayment

  class API

    def self.ensure_config!
      raise "Micropayment.setup has not been called yet. See github.com/GeneralScripting/micropayment"  unless Config.complete
    end

    def self.call(url, method, data={})
      ensure_config!
      data[:action]     = method
      data[:accessKey]  = Config.api_key
      data[:testMode] ||= Config.sandbox||0   if Config.sandbox
      data.delete_if {|k,v| v.nil? }
      uri = Addressable::URI.parse(url)
      uri.query_values = data
      puts uri.inspect
    end

  end

end