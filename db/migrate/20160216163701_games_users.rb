class GamesUsers < ActiveRecord::Migration
  def change
  	create_table :games_users, id: false do |t|
    	t.integer :user_id
    	t.integer :game_id

      t.timestamps null: false
    end
  end
end
