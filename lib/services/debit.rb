# encoding: utf-8

module Micropayment
  class Debit

    URL = BASE_URL + "debit/v1.4/nvp/"

    class << self

      def execute(method, data={})
        API.call(URL, method, data)
      end

      # löscht alle Kunden und Transaktionen in der Testumgebung
      def reset_test
        execute(:resetTest, :testMode => 1)
      end

      def customerCreate
        execute(:customerCreate)
      end

    end

  end
end