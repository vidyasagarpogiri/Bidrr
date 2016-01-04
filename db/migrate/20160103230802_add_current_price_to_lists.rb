class AddCurrentPriceToLists < ActiveRecord::Migration
  def change
    add_column :lists, :current_price, :money
  end
end
