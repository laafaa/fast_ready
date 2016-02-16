class AddColumnLoginPhoneNumberToUser < ActiveRecord::Migration
  def change
  	add_column :users, :login, :string, null: false, default: ""
  	add_column :users, :phone_number, :integer
  	add_column :users, :balance, :integer, default: 0
  end
end
