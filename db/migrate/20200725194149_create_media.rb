class CreateMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :media do |t|
      t.string :address
      t.string :call
      t.string :email
      t.text :timing
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :pinterest

      t.timestamps
    end
  end
end
