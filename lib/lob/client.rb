require "lob/resources/address"
require "lob/resources/area"
require "lob/resources/bank_account"
require "lob/resources/check"
require "lob/resources/country"
require "lob/resources/intl_verifications"
require "lob/resources/letter"
require "lob/resources/postcard"
require "lob/resources/route"
require "lob/resources/state"
require "lob/resources/us_verifications"

module Lob
  class Client

    attr_reader :config

    def initialize(config = nil)
      if config.nil? || config[:api_key].nil?
        raise ArgumentError.new(":api_key is a required argument to initialize Lob")
      end

      @config = config
    end

    def areas
      Lob::Resources::Area.new(config)
    end

    def addresses
      Lob::Resources::Address.new(config)
    end

    def bank_accounts
      Lob::Resources::BankAccount.new(config)
    end

    def checks
      Lob::Resources::Check.new(config)
    end

    def countries
      Lob::Resources::Country.new(config)
    end

    def intl_verifications
      Lob::Resources::IntlVerifications.new(config)
    end

    def letters
      Lob::Resources::Letter.new(config)
    end

    def postcards
      Lob::Resources::Postcard.new(config)
    end

    def routes
      Lob::Resources::Route.new(config)
    end

    def states
      Lob::Resources::State.new(config)
    end

    def us_verifications
      Lob::Resources::USVerifications.new(config)
    end

  end
end
