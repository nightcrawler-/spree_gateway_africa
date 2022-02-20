# frozen_string_literal: true

class RenamePhoneNumberOnFlutterwaveRequests < ActiveRecord::Migration[6.1]
  def change
    rename_column :spree_flutterwave_requests, :phone_number, :phone
  end
end
