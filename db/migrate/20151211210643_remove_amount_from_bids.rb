class RemoveAmountFromBids < ActiveRecord::Migration
  def change
  	remove_column :bids, :amount, :money
  end
end
