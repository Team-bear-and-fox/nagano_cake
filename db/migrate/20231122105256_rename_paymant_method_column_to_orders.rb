class RenamePaymantMethodColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :paymant_method, :payment_method
  end
end
