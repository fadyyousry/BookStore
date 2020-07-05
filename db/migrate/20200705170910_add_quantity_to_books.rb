class AddQuantityToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :quantity, :integer
    add_column :books, :is_pdf, :boolean
  end
end
