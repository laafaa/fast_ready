class CreateUserTransactions < ActiveRecord::Migration
  def change
    create_table :user_transactions do |t|
    	t.integer :user_id
    	t.float :sum
    	t.boolean :satisfy, null: false, default: false
		t.timestamps null: false
    end
  end
end
