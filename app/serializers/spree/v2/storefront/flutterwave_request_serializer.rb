module Spree
    module V2
      module Storefront
        class FlutterwaveRequestSerializer < BaseSerializer
          set_type :payment
  
          has_one :source, polymorphic: true
          has_one :payment_method
  
          attributes :amount, :response_code, :payment_instrument_number, :name,
                     :payment_method_id, :payment_method_name, :state, :public_metadata
        end
      end
    end
end