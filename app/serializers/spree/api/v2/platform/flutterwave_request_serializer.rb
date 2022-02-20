# frozen_string_literal: true

module Spree
  module Api
    module V2
      module Platform
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
end
