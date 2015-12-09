class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_table :users, force: :cascade do |t|
    t.string :email
    t.string :password
  	end
  end
end
