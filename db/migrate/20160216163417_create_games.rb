class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.integer :rate
    	t.integer :winner

      t.timestamps null: false
    end
  end
end
