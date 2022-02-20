class RenamePhoneOnFlutterwaveRequests < ActiveRecord::Migration[6.1]
  def change
    rename_column :spree_flutterwave_requests, :phone, :payment_instrument_number
  end
end
