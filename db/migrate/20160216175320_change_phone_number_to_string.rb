class ChangePhoneNumberToString < ActiveRecord::Migration
  def change
  	change_column :users, :phone_number, :string
  	rename_column :users, :phone_number, :phone
  end
end
