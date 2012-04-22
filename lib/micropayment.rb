require "net/https"
require "cgi"

module Micropayment

  BASE_URL = 'https://webservices.micropayment.de/public/'

  autoload :API,      'services/api'
  autoload :Debit,    'services/debit'

end