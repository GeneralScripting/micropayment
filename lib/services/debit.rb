module Micropayment
  class Debit

    URL = BASE_URL + "debit/v1.4/nvp/"

    class << self

      def execute(method, data={})
        self.call(URL, method, data)
      end

      def reset_test
        self.execute(:resetTest, :testMode => 1)
      end

    end

  end
end