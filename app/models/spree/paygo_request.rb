# frozen_string_literal: true

module Spree
  class PaygoRequest < Spree::Base
    attr_accessor :cc_type, :gateway_payment_profile_id, :gateway_customer_profile_id, :last_digits, :name, :payment_instrument_number, :month, :year, :account_no, :msisdn # Dunno if this is necessary here, will test baadae

    # Validations
    # validates :name, :payment_instrument_number, presence: true

    # Associations
    belongs_to :payment_method

    belongs_to :user, class_name: Spree.user_class.to_s, optional: true

    has_many :payments, as: :source
  end
end
