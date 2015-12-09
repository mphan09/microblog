class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts, force: :cascade do |t|
    t.string  :body
    t.integer :user_id
    t.datetime :posted_on
	end
  end
end
