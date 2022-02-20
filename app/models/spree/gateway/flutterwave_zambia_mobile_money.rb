require 'socket'

module Spree
    class Gateway::FlutterwaveZambiaMobileMoney < Gateway 
      preference :public_key, :string
      preference :secret_key, :string

      attr_accessor :rave

      def provider_class
        Spree::Gateway::FlutterwaveZambiaMobileMoney
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
        do_rave_zambia_things(options, _amount, _transaction_details)
      end

      def do_rave_zambia_things(options, amount, transaction_details)
          @rave = RaveRuby.new(preferences[:public_key], preferences[:secret_key], true)

          # TODO:: phonenumber: get from tx details -> billing -> shipping -> user in that order
          # This is used to perform zambia mobile money charge
          payload = {
            "amount" => (amount / 100).to_i.to_s,
            "phonenumber" => transaction_details.payment_instrument_number,
            "firstname" => "Sam", #transaction_details.name.split(' ')[0],
            "lastname" => "Wilson", #transaction_details.name.split(' ')[1],
            "network" => MobileNetworkService.new(transaction_details.payment_instrument_number).call,
            "email" => options[:email],
            "IP" => ip_address,
            "redirect_url" => "https://webhook.site/40eb91be-8eda-406b-85f9-881758cbe263",
          }

          print "payload: #{payload.inspect}\n#############\n"

          # To initiate zambia mobile money transaction
          charge_zambia_mobile_money = ZambiaMobileMoney.new(rave)

          response = charge_zambia_mobile_money.initiate_charge(payload)

          # TODO:: At this point, redirect to the said link for OTP verification
          print response.inspect + "\n#############\n"

          # To verify the zambia mobile money transaction
          # Doesn't exist yet, verify the transaction using the transaction reference
          # Set redirect url and ref for later user
          # response = charge_zambia_mobile_money.verify_charge(response["txRef"])
          transaction_details.name = response["link"]
          transaction_details.save!

          print response.inspect + "\n#############\n"
  
          # Don't set a success result yet. 
          ActiveMerchant::Billing::Response.new(!response["error"], response["status"], response.merge!(payload), {})
      end

      def ip_address 
        ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
        ip.ip_address
      end

    end
end
