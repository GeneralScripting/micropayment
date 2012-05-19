require "addressable/uri"
require "net/https"
require "cgi"

module Micropayment

  autoload :Config,   'services/config'
  autoload :API,      'services/api'
  autoload :Debit,    'services/debit'

  def self.assert_valid_keys(opts, *valid_keys)
    valid_keys.flatten!
    opts.each_key do |k|
      raise(ArgumentError, "Unknown key: #{k}") unless valid_keys.include?(k)
    end
  end

  def self.assert_keys_exists(opts, *keys)
    keys.flatten!
    opt_keys = opts.keys
    keys.each do |k|
      raise(ArgumentError, "Mandatory key missing: #{k}") unless opt_keys.include?(k)
    end
  end

end