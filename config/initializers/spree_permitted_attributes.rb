# frozen_string_literal: true

module Spree
  module PermittedAttributes
    @@source_attributes += %i[payment_instrument_number name account_number routing_number account_holder_type
                              account_holder_name status]
  end
end
