module Micropayment

  class API

    def self.call(url, method, data)
      puts "called: #{url}"
      puts "method: #{method}"
      puts "data: #{data.inspect}"
    end

  end

end