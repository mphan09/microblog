


require 'sinatra'

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




# require 'sinatra'



# def send_email(message_body, name_input, email_input)
#  m = Mandrill::API.new 
# message = {  
#   :subject=> "Hello from the Mandrill API",  
#   :from_name=> name_input,  
#   :text=> message_body,  
#   :to=>[{:email=> "recipient@dom.com", :name=> "Rec Name"}],  
#   :html=>"<html><h1>Hi <strong>message</strong>, how are you?</h1></html>",  
#   :from_email=>email_input } 
# end


# post "/contact-us-post" do
#   # this invokes the send_email method defined above
#   send_email(params[:message_body],params[:name_input],params[:email_input])
# end

