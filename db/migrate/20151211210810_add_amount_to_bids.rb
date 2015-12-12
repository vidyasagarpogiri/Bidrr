class AddAmountToBids < ActiveRecord::Migration
  def change
  	  	add_column :bids, :amount, :integer
  end
end
