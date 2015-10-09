

require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
# require './models'

# set :database, "sqlite3:exercise2.sqlite3"



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





get "/sign-in" do
  erb :mainpage
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first

  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    flash[:notice] = "welcome!"
  else
    flash[:alert] = "oh no, wrong username / password"
  end

  redirect "/"
end











# post '/sign-in' do     
#    puts "my params are" + params.inspect   end

# post '/sign-in' do   
#    @user = User.where(username: params[:username]).first   
#    if @user.password == params[:password]     
#        redirect '/'   
#    else     
#        redirect '/login-failed'   end end

# post '/sign-in' do   
#    @user = User.where(username: params[:username]).first   
#    if @user && @user.password == params[:password]                       session[:user_id] = @user.id     
#        flash[:notice] = "You've been signed in successfully."   
#    else     
#        flash[:alert] = "There was a problem signing you in."   end   
#    redirect "/" 
# end

# def current_user     
#    if session[:user_id]       
#        @current_user = User.find(session[:user_id])     
#    end
# end

#    # when a form is sent using a POST request to the /sign-in # url in your app... 
# post '/sign-in' do   
#    # assign the variable @user to the user that has the   
#    # same username given inside of the params hash   
#    # use .first because .where always returns an array,   
#    # even if there is one result returned and we only   
#    # want one user   
#    @user = User.where(username: params[:username]).first   
#    #if the user found's password is equal to the submitted   
#    # password...   
#    if @user.password == params[:password]     
#        #send them to the homepage     
#        redirect '/'   else     
#        # otherwise, send them to the ‘login-failed' page     
#        # (assuming a view/route like this exists)     
#        redirect "/login-failed"   
#    end 
# end

