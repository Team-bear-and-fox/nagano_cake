class RenamePaymantTotalColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :paymant_total, :payment_total
  end
end
