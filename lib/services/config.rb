module Micropayment

  class Config

    BASE_URL  = 'https://webservices.micropayment.de/public/'

    VALID_OPTION_KEYS = [ :complete, :api_key, :sandbox ]

    class << self
      attr_accessor *VALID_OPTION_KEYS

      def sandbox_param
        sandbox ? 1 : nil
      end
    end

  end

end