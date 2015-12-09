# any models in this file will be available to you in the
#   app.rb file because of the require "./models" line in the
#   app.rb file

# we are inheriting methods like
#   User.create, User.find, User.all from ActiveRecord::Base
class User < ActiveRecord::Base
  # here we are basically telling ActiveRecord to define the
  #   @user.posts method
  #   (assuming we have a @user instance variable)
  has_many :posts

  # the way we describe follows is as a list
  #   of people that have followed you
  # when we want to see a list of all the follows we have
  #   we must tell it to use the followee_id foreign key
  #   in the follows table to make that association
  #   we must also tell it to use the Follow class
  has_many :follows, foreign_key: :followee_id

  # when we want to see a list of all the followings we are doing
  #   we must tell it to use the follower_id foreign key
  #   in the follows table to make that association
  #   we must also tell it to use the Follow class
  has_many :followings, foreign_key: :follower_id, class_name: "::Follow"

  # in order to simplify the process of finding followers
  #   we create this has many through association
  #   we must also tell it to use the User class
  has_many :followers, through: :follows, class_name: User

  # in order to simplify the process of finding the followees
  #   we create this has many through association
  #   we must also tell it to use the User class
  has_many :followees, through: :followings, class_name: User
end

# we are inheriting methods like
#   Post.create, Post.find, Post.all from ActiveRecord::Base
class Post < ActiveRecord::Base
  # here we are basically telling ActiveRecord to define the
  #   @post.user method
  #   (assuming we have a @post instance variable)
  belongs_to :user
end

# we are inheriting methods like
#   Follow.create, Follow.find, Follow.all from ActiveRecord::Base
class Follow < ActiveRecord::Base
  # here we are basically telling ActiveRecord to define the
  #   @follow.follower method
  #   (assuming we have a @follower instance variable)
  #   and we are telling it to return an object of class type User
  belongs_to :follower, foreign_key: :follower_id, class_name: User

  # here we are basically telling ActiveRecord to define the
  #   @follow.followee method
  #   (assuming we have a @followee instance variable)
  #   and we are telling it to return an object of class type User
  belongs_to :followee, foreign_key: :followee_id, class_name: User
end