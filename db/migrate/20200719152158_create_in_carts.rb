class CreateInCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :in_carts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.timestamp :payment_time
      t.string :status

      t.timestamps
    end
  end
end
