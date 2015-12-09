class CreateFollowsTable < ActiveRecord::Migration
  def change
  	create_table :follows do |t|
  		t.integer :follower_id
  		t.integer :followee_id
  	end
  end
end
