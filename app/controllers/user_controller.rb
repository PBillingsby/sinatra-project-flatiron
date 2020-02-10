class UserController < ApplicationController
  
  get '/new' do
    erb :'/users/registrations/new'
  end

  post '/users' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    new_user_handling
  end

  get '/login' do
    is_logged_in? ? (redirect "/users/#{current_user.id}") : (erb :'/users/sessions/login') # Unless already logged in, show login form.
  end

  post '/login' do
    login_handling
  end

  get '/users/:id' do
    if !current_user
      redirect "/"
    elsif params["id"].to_i != current_user.id  # If user try to access a different user page.
      flash[:message] = "You are not authorized to access this profile."
      redirect "/users/#{session[:user_id]}"
    else
      @user = User.find(params[:id])
      erb :'users/show'
    end
  end
  
  get '/logout' do
    session.clear
    redirect "/"
  end 
end