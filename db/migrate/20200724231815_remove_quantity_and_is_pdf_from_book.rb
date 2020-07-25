class RemoveQuantityAndIsPdfFromBook < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :quantity, :integer
    remove_column :books, :is_pdf, :boolean
  end
end
