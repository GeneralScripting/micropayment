require "net/https"
require "cgi"

module Micropayment

  BASE_URL = 'https://webservices.micropayment.de/public/'

  autoload :Debit,    'services/debit'

  def self.call(url, method, data)
    puts "called: #{url}"
    puts "method: #{method}"
    puts "data: #{data.inspect}"
  end

end