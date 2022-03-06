# frozen_string_literal: true

module Spree
  class Gateway::PaygoMtnCollection < Gateway
    preference :username, :string
    preference :password, :string
    preference :service_id, :string
    preference :client_id, :string

    def provider_class
      Spree::Gateway::PaygoMtnCollection
    end

    def payment_source_class
      PaygoRequest
    end

    def auto_capture?
      true
    end

    def method_type
      'paygo_request'
    end

    def purchase(_amount, _transaction_details, options = {})
      # Over here is where the payments will be made from the respective wallet based on user's balance
      # Possibly redirect to flutterwave or make use of their gem/APIs
      # Ideally to initiate a payment somehow and return the active billing state
      # Check other gateway implementations, esp callback based/async/background/other service

      Rails.logger.info "purchase options: #{options.inspect}"
      Rails.logger.info "purchase amount: #{_amount.inspect}"
      Rails.logger.info "purchase transaction_details: #{_transaction_details.inspect}"
      do_paygo_mpesa(options, _amount, _transaction_details)
    end

    def do_paygo_mpesa(_options, _amount, _transaction_details)
      body = {
        transactionid: '3',
        accountno: '2609893939393',
        currencycode: 'EUR',
        timestamp: '7777',
        amount: 2,
        msisdn: '00000000',
        payload: { acounttype: 'MSISDN' }
      }

      @paygo = Paygo::MtnCollectionService.new(
        preferences[:username],
        preferences[:password],
        preferences[:service_id],
        preferences[:client_id],
        body
      )

      response = @paygo.call

      Rails.logger.debug "#{response.inspect}\n#############\n"

      ActiveMerchant::Billing::Response.new(!response['error'], response['payload']['statusDescription'], response, {})
    end
  end
end
