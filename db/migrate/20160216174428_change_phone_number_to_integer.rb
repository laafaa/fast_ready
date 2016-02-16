class ChangePhoneNumberToInteger < ActiveRecord::Migration
  def change
  	change_column :users, :phone_number, :tel
  end
end
