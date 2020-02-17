class UserController < ApplicationController
  
  get '/signup' do
    erb :'/users/registrations/new'
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if params["password"] == params["password2"] && @user.save # ASK IF password2 VALUE CAN BE ACCESSED /// SECURITY ISSUE?
      session[:user_id] = @user.id
      redirect "/users/#{current_user.id}"
    else
      flash[:message] = "Please enter valid username, email and password"
      redirect "/signup"
    end
  end

  get '/login' do
    current_user ? (redirect "/users/#{current_user.id}") : (erb :'/users/sessions/login') # Unless already logged in, show login form.
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) # Authenticate user.
      session[:user_id] = @user.id
      redirect "/users/#{current_user.id}"
    else
      flash[:message] = "Log in details incorrect. Try again."
      redirect "/login"
    end
    if session[:user_id] == current_user.id # Handle if user is already logged in.
      redirect "/users/#{current_user.id}"
    end
  end

  get '/users/:id' do
    if !current_user
      flash[:message] = "You are not authorized to access this profile."
      redirect "/"
    elsif params["id"].to_i != current_user.id  # If user try to access a different user page.
      flash[:message] = "You are not authorized to access this profile."
      redirect "/users/#{current_user.id}"
    else
      @user = User.find(params[:id])
      erb :'users/show'
    end
  end
  get '/logout' do
    session.clear
    redirect "/login"
  end
end