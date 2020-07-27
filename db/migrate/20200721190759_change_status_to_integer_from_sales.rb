class ChangeStatusToIntegerFromSales < ActiveRecord::Migration[6.0]
  def self.up  
    change_column :sales, :status, 'integer USING CAST(status AS integer)'
  end
  
  def self.down
    change_column :sales, :status, 'varchar USING CAST(status AS varchar)'
  end
end
