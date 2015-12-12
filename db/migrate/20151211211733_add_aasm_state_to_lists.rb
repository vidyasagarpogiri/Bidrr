class AddAasmStateToLists < ActiveRecord::Migration
  def change
    add_column :lists, :aasm_state, :string
  end
end
