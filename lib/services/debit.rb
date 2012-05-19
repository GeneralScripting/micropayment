# encoding: utf-8

module Micropayment
  class Debit

    URL = Config::BASE_URL + "debit/v1.4/nvp/"

    class << self

      def execute(method, data={})
        API.call(URL, method, data)
      end

      def assert_valid_keys(*opts)
        Micropayment.assert_valid_keys *opts
      end

      def assert_keys_exists(*opts)
        Micropayment.assert_keys_exists *opts
      end


      # "löscht alle Kunden und Transaktionen in der Testumgebung"
      def reset_test
        execute(:resetTest, :testMode => 1)
      end

      # "legt neuen Kunden an"
      def customerCreate(options={})
        assert_valid_keys(options, :customerId, :freeParams)
        assert_keys_exists(options, :customerId)
        execute(:customerCreate, options)
      end

      # "ordnet weitere freie Parameter dem Kunden zu, oder ändert sie"
      def customerSet(options={})
        assert_valid_keys(options, :customerId, :freeParams)
        assert_keys_exists(options, :customerId)
        execute(:customerSet, options)
      end

      # "ermittelt alle freien Parameter des Kunden"
      def customerGet(options={})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:customerGet, options)
      end

      # "ermittelt alle Kunden"
      def customerList(options={})
        assert_valid_keys(options, :from, :count)
        execute(:customerList, options)
      end

      # "erzeugt oder ändert Bankverbindung eines Kunden"
      def bankaccountSet(options={})
        assert_valid_keys(options, :customerId, :bankCode, :accountNumber, :accountHolder, :country)
        assert_keys_exists(options, :customerId, :bankCode, :accountNumber, :accountHolder)
        execute(:bankaccountSet, options)
      end

      # "ermittelt die Bankverbindung des Kunden"
      def bankaccountGet(options={})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:bankaccountGet, options)
      end

      # "prüft Bankleitzahl und ermittelt Banknamen"
      def bankCheck(options={})
        assert_valid_keys(options, :country, :bankCode)
        assert_keys_exists(options, :bankCode)
        execute(:bankCheck, options)
      end

      # "prüft Bankverbindung und ermittelt Banknamen"
      def bankaccountCheck(options={})
        assert_valid_keys(options, :country, :bankCode, :accountNumber)
        assert_keys_exists(options, :bankCode, :accountNumber)
        execute(:bankaccountCheck, options)
      end

      # "Sperrt Bankverbindung oder gibt sie frei"
      def bankaccountBar(options={})
        assert_valid_keys(options, :country, :bankCode, :accountNumber, :barStatus)
        assert_keys_exists(options, :bankCode, :accountNumber, :barStatus)
        execute(:bankaccountBar, options)
      end

      # "erzeugt oder ändert Adressdaten eines Kunden"
      def addressSet(options={})
        assert_valid_keys(options, :customerId, :firstName, :surName, :street, :zip, :city, :country)
        assert_keys_exists(options, :customerId, :firstName, :surName, :street, :zip, :city)
        execute(:addressSet, options)
      end

      # "ermittelt die Adresse des Kunden"
      def addressGet(options={})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:addressGet, options)
      end

      # "erzeugt oder ändert Kontaktdaten eines Kunden"
      def contactDataSet(options={})
        assert_valid_keys(options, :customerId, :email, :phone, :mobile)
        assert_keys_exists(options, :customerId)
        execute(:contactDataSet, options)
      end

      # "ermittelt die Kontaktdaten des Kunden"
      def contactDataGet(options={})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:contactDataGet, options)
      end

      # "erzeugt einen neuen Bezahlvorgang"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "INIT" bzw. "REINIT" aus"
      def sessionCreate(options={})
        assert_valid_keys(options, :customerId, :sessionId, :project, :projectCampaign, :account, :webmasterCampaign, :amount, :currency, :title, :payText, :ip, :freeParams)
        assert_keys_exists(options, :customerId, :project)
        execute(:sessionCreate, options)
      end

      # "ordnet weitere freie Parameter der Session zu, oder ändert sie"
      def sessionSet(options={})
        assert_valid_keys(options, :sessionId, :freeParams)
        assert_keys_exists(options, :sessionId)
        execute(:sessionSet, options)
      end

      # "ermittelt Daten eines Bezahlvorgangs"
      def sessionGet(options={})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:sessionGet, options)
      end

      # "bestätigt den Lastschrifteinzug eines Vorgangs"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "APPROVED" aus"
      def sessionApprove(options={})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:sessionApprove, options)
      end

      # "übermittelt alle Bezahlvorgänge eines Kunden"
      def sessionList(options={})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:sessionList, options)
      end

      # "simuliert die Abbuchung für alle bestätigten Vorgänge"
      # => "erzeugt für jede bestätigte Session eine neue Transaktion mit dem Typ 'BOOKING' und löst die Benachrichtigung transactionCreate aus"
      # => "löst die Benachrichtigung sessionStatus mit dem Status 'CHARGED' aus"
      def sessionChargeTest(options={})
        execute(:sessionChargeTest, :testMode => 1)
      end

      # "simuliert Stornierung eines einzelnen Vorgangs"
      # => "erzeugt eine neue Transaktion mit dem Typ "REVERSAL" und löst die Benachrichtigung transactionCreate aus"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "REVERSED" aus"
      def sessionReverseTest(options={})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:sessionReverseTest, options.merge(:testMode => 1))
      end

      # "simuliert die komplette Nachzahlung eines stornierten Vorgangs"
      # => "erzeugt eine neue Transaktion mit dem Typ "BACKPAY" und löst die Benachrichtigung transactionCreate aus"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "RECHARGED" aus, wenn der gesamte offene Betrag beglichen wurde"
      def sessionRechargeTest(options={})
        assert_valid_keys(options, :sessionId, :amount)
        assert_keys_exists(options, :sessionId)
        execute(:sessionRechargeTest, options.merge(:testMode => 1))
      end

      # "Veranlasst eine (Teil-)Gutschrift und überweist sie zurück"
      # => "erzeugt eine neue Transaktion mit dem Typ "REFUND" und löst die Benachrichtigung transactionCreate aus"
      def sessionRefund(options={})
        assert_valid_keys(options, :sessionId, :bankCode, :accountNumber, :accountHolder, :amount, :payText)
        assert_keys_exists(options, :sessionId)
        execute(:sessionRefund, options)
      end

      # "simuliert Stornierung der letzten Gutschrift,"
      # => "erzeugt eine neue Transaktion mit dem Typ "REFUNDREVERSAL" und löst die Benachrichtigung transactionCreate aus"
      def sessionRefundReverseTest(options={})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:sessionRefundReverseTest, options.merge(:testMode => 1))
      end

      # "erstellt eine Transaktion vom Typ "EXTERNAL""
      # => "löst die Benachrichtigung transactionCreate aus"
      def transactionCreate(options={})
        assert_valid_keys(options, :sessionId, :date, :amount, :description)
        assert_keys_exists(options, :sessionId, :amount)
        execute(:transactionCreate, options)
      end

      # "ermittelt alle Transaktionen für einen Bezahlvorgang"
      def transactionList(options={})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:transactionList, options)
      end

      # "ermittelt Daten einer Transaktion"
      def transactionGet(options={})
        assert_valid_keys(options, :transactionId)
        assert_keys_exists(options, :transactionId)
        execute(:transactionGet, options)
      end

    end

  end
end