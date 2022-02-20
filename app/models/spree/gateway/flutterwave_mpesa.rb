# frozen_string_literal: true

require 'socket'

module Spree
  class Gateway::FlutterwaveMpesa < Gateway
    preference :public_key, :string
    preference :secret_key, :string

    attr_accessor :rave

    def provider_class
      Spree::Gateway::FlutterwaveMpesa
    end

    def payment_source_class
      FlutterwaveRequest
    end

    def auto_capture?
      true
    end

    def method_type
      'flutterwave_request'
    end

    def purchase(_amount, _transaction_details, options = {})
      # Over here is where the payments will be made from the respective wallet based on user's balance
      # Possibly redirect to flutterwave or make use of their gem/APIs
      # Ideally to initiate a payment somehow and return the active billing state
      # Check other gateway implementations, esp callback based/async/background/other service

      Rails.logger.info "purchase options: #{options.inspect}"
      Rails.logger.info "purchase amount: #{_amount.inspect}"
      Rails.logger.info "purchase transaction_details: #{_transaction_details.inspect}"
      do_rave_mpesa_things(options, _amount, _transaction_details)
    end

    def do_rave_mpesa_things(options, amount, transaction_details)
      @rave = RaveRuby.new(preferences[:public_key], preferences[:secret_key], true)

      # Create a transaction
      # This is used to perform mpesa charge
      payload = {
        'amount' => (amount / 100).to_i.to_s,
        'phonenumber' => transaction_details.payment_instrument_number,
        'email' => options[:email],
        'IP' => ip_address,
        'narration' => "Payment for order #{options[:order_id]}"
      }

      Rails.logger.debug "payload: #{payload.inspect}\n#############\n"

      # To initiate mpesa transaction
      charge_mpesa = Mpesa.new(rave)

      response = charge_mpesa.initiate_charge(payload)

      Rails.logger.debug "#{response.inspect}\n#############\n"

      # To verify the mpesa transaction
      # response = charge_mpesa.verify_charge(response["txRef"])

      # print response.inspect + "\n#############\n"

      ActiveMerchant::Billing::Response.new(!response['error'], response['data']['acctmessage'], response, {})
    end

    def ip_address
      ip = Socket.ip_address_list.detect(&:ipv4_private?)
      ip.ip_address
    end
  end
end
