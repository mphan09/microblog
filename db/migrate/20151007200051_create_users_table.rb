class CreateUsersTable < ActiveRecord::Migration
 
      def change
        
      create_table :users do |t|
          t.string :username
          t.string :password
          t.string :fname
          t.string :lname
          t.string :info
      end
      
      create_table :profiles do |t|
          t.integer :user_id
          t.string :info
      end
      
      create_table :posts do |t|
          t.integer :user_id
          t.string :subject
          t.string :body
          t.datetime :posted_on
      end
      create_table :follows do |t|
        t.integer :follower_id
        t.integer :followee_id
      end
  end
end
