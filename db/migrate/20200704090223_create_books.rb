class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.references :publisher, foreign_key: true
      t.date :published_date
      t.text :description
      t.string :isbn
      t.integer :page_count
      t.string :image_link
      t.string :language
      t.decimal :price

      t.timestamps
    end
  end
end
