class ChangeStatusToIntegerFromSales < ActiveRecord::Migration[6.0]
  def change
    change_column :sales, :status, :integer
  end
end
