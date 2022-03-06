# frozen_string_literal: true

class AddToSpeePaygoRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_paygo_requests, :payment_method_id, :bigint
    add_column :spree_paygo_requests, :user_id, :bigint
  end
end
