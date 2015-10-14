class User < ActiveRecord::Base   
   has_many :posts
   has_one :profile
   has_many :posts

   has_many :relationships, foreign_key: :follower_id
   has_many :followed, through: :relationships, source: :followed

end

class Profile < ActiveRecord::Base
   belongs_to :user
end

class Post < ActiveRecord::Base
   belongs_to :user
end


class Relationship < ActiveRecord::Base
belongs_to :followed, class_name: 'User'
end

# class UsersController < ApplicationController

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end

#   def create
#     @user = User.new(params[:user])    # Not the final implementation!
#     if @user.save
#       # Handle a successful save.
#     else
#       render 'new'
#     end
#   end
# end