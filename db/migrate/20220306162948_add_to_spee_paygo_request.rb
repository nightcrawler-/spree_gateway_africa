# frozen_string_literal: true

class AddToSpeePaygoRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_paygo_requests, :payment_method_id, :bigint
    add_column :spree_paygo_requests, :user_id, :bigint
    add_column :spree_paygo_requests, :account_number, :string
    add_column :spree_paygo_requests, :msisdn, :string
  end
end
