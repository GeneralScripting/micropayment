module Micropayment

  class Config

    BASE_URL  = 'https://webservices.micropayment.de/public/'

    VALID_OPTION_KEYS = [ :complete, :api_key, :sandbox ]

    class << self
      attr_accessor *VALID_OPTION_KEYS
    end

    def self.setup
      #Micropayment::Config.url = BASE_URL
    end

  end

end