require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require './models'

set :database, "sqlite3:thetable.sqlite3"
enable :sessions


  get '/' do    
   erb :home, :layout => false
  end

   get '/signup' do    
   erb :signup, :layout => false
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


  get "/sign-in" do
    erb :mainpage
  end

post "/sign-up-post" do
  @user = User.create(username: params[:username], password: params[:password], fname: params[:fname], lname: params[:lname], email: params[:email])
  my_user = User.find_by(username: params[:username])
  session[:user_id] = my_user.id
    redirect '/mainpage'
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first

  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    flash[:notice] = "welcome!"
  else
    flash[:alert] = "oh no, wrong username / password"
  end
end











