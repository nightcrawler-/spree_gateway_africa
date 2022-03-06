# frozen_string_literal: true

class CreateSpreePaygoRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :spree_paygo_requests do |t|
      t.string :account_no
      t.string :msisdn

      t.timestamps
    end
  end
end
