class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.text :details
      t.date :end_date
      t.money :reserve_price

      t.timestamps null: false
    end
  end
end
