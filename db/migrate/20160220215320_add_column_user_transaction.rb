class AddColumnUserTransaction < ActiveRecord::Migration
  def change
  	add_column :user_transactions, :description, :string
  end
end
