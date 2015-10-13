require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require './models'

set :database, "sqlite3:thetable.sqlite3"
enable :sessions


  get '/' do    
   erb :home, :layout => false
  end

  get "/users/:id/follow" do
  user = User.find(params[:id])
  current_user.follow!(user) if user
  flash[:notice] = "User followed successfully."
  redirect "/"
end



  post "/" do
    @user = User.where(email: params[:email]).first
    if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    flash[:info] = "You are now logged in"
    redirect "/mainpage"
  else
    flash[:alert] = "Your password is incorrect"
    redirect "/"
    end
  end



  get '/signup' do    
 
   erb :signup, :layout => false
  end



  post "/signup" do
  @user = User.create(username: params[:username], email: params[:email], password: params[:password])
  session[:user_id] = @user.id
    redirect '/mainpage' 
  end




  get "/sign-in" do
    erb :home
  end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
    if @user.email && @user.password == params[:password]
        redirect '/mainpage'
      flash[:notice] = "welcome!"
    else
        redirect '/'
      flash[:alert] = "oh no, wrong username / password"
    end
end



get "/logout" do
  # here we set the session user_id key value
  #   pair to nil because in the other routes
  #   when they check to see if the user is logged in
  #   they are checking to see if the user_id
  #   exists within the session
  # in doing all this using laymen's terms it means
  #   the user is logged out
  session[:user_id] = nil

  # tell the person on the website that they are now
  #   logged out
  flash[:info] = "You are now logged out"

  # this redirects to the get "/" route
  redirect "/"
end



  get '/mainpage' do    
   erb :mainpage
  end

 get '/profile' do    
   erb :profile
  end

  get '/editprofile' do
    erb :editprofile
  end


# HTTP GET method and "/posts/new" action route
get "/posts/new" do
  # this will output whatever is within the new_post.erb template
  erb :new_post
end

# HTTP GET method and "/posts" action route
get "/posts" do
  # this loads all the created posts from the database
  #   and stores it within the @posts instance variable
  #   ONLY OF THE LOGGED IN USER
  @posts = Post.where(user_id: session[:user_id])

  # this will output whatever is within the posts.erb template
  erb :posts
end

# HTTP GET method and "/posts/followers" action route
get "/posts/followers" do
  # this loads all the created posts from the logged in user's
  #   followers
  # this block here puts all the posts into an array
  @posts = current_user.followers.inject([]) do |posts, follower|
    # this takes the current follower's posts and add them to the
    #   posts array we are building
    posts << follower.posts
  end

  # at this point the the posts are in the form of an array within an
  #   an array so we use the ruby array method (flatten) which makes
  #   it so that it is goes from say [[1,2],[5,6],[1,3]] to [1,2,3,5,6,1,3]
  #   http://ruby-doc.org/core-2.2.3/Array.html#method-i-flatten
  @posts.flatten!

  # this will output whatever is within the posts.erb template
  # notice how this also goes to the posts.erb template
  #   think DRY (Don't Repeat Yourself)
  erb :posts
end

# HTTP GET method and "/posts/all" action route
get "/posts/all" do
  # this loads all the created posts from the database
  #   and stores it within the @posts instance variable
  @posts = Post.all

  # this will output whatever is within the posts.erb template
  # notice how this also goes to the posts.erb template
  #   think DRY (Don't Repeat Yourself)
  erb :posts
end

# HTTP GET method and "/users/:user_id/posts" action route
get "/users/:user_id/posts" do
  # this loads all the created posts from the database
  #   and stores it within the @posts instance variable
  #   ONLY OF THE SPECIFIC USER WITH THE user_id set in the browser
  #   so entering "localhost:4567/users/5/posts" would display
  #   the posts of the user with an id of 5
  @posts = Post.where(user_id: params[:user_id])

  # this will output whatever is within the posts.erb template
  # notice how this also goes to the posts.erb template
  #   think DRY (Don't Repeat Yourself)
  erb :posts
end

# HTTP POST method and "/posts" action route
post "/posts" do
  # here we are creating a post with the body of what was
  #   set in the form body input field and user_id of
  #   whatever the logged in user is
  # this creates an association between the new post and
  #   the logged in user
  Post.create(body: params[:body], user_id: session[:user_id])

  # this redirects to the get "/posts" route so someone
  #   can see all their posts
  redirect "/posts/all"
end
