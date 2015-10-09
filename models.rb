class User < ActiveRecord::Base   
   has_many :posts
   has_one :profile
   has_many :posts
end

class Profile < ActiveRecord::Base
   belongs_to :user
end

class Post < ActiveRecord::Base
   belongs_to :user
end
