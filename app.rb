require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"

set :database, "sqlite3:database.sqlite3"

enable :sessions


get "/" do
  erb :login, :layout => false
end

get "/login" do
  erb :login, :layout => false
end

get "/index"  do
  erb  :index
end


post "/login" do

  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]

    session[:user_id] = @user.id
    flash[:info] = "You are now logged in"
    redirect "/index"
  else

    flash[:alert] = "Your password is incorrect"
    redirect "/login"
  end
end


get "/signup" do
  flash[:info] = "You are now signed up and logged in"

  erb :signup, :layout => false
end

post "/signup" do
  @user = User.create(email: params[:email], password: params[:password])
  session[:user_id] = @user.id
  redirect "/index"
end

get "/logout" do
  session[:user_id] = nil

  flash[:info] = "You are now logged out"

  redirect "/login"
end


get "/posts/new" do
  erb :new_post
end

get "/posts" do
  @posts = Post.where(user_id: session[:user_id])
  erb :posts
end


get "/posts/followers" do
  @posts = current_user.followers.inject([]) do |posts, follower|
    posts << follower.posts
  end

  @posts.flatten!
  erb :posts
end


get "/posts/all" do
  @posts = Post.all
  erb :posts
end


get "/users/:user_id/posts" do
  @posts = Post.where(user_id: params[:user_id])
  erb :posts
end


post "/posts" do
  Post.create(body: params[:body], user_id: session[:user_id])
  redirect "/posts/all"
end


get "/users/all" do
  @users = User.all
  erb :users  
end


get "/followees" do
  @users = current_user.followees
  erb :users
end


get "/followers" do
  @users = current_user.followers
  erb :followers
end


get "/users/:followee_id/follow" do
  Follow.create(follower_id: session[:user_id], followee_id: params[:followee_id])
  redirect "/users/all"
end


get "/users/:followee_id/unfollow" do
  @follow = Follow.where(follower_id: session[:user_id], followee_id: params[:followee_id]).first
  @follow.destroy
  redirect "/users/all"
end


def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end