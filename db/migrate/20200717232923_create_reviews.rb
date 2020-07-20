class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.decimal :rating
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
    end
  end
end
