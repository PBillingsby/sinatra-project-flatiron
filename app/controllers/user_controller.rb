class UserController < ApplicationController
  
  get '/new' do
    erb :'/users/registrations/new'
  end

  post '/users' do
    @user = User.new(params) # User.new
    session[:user_id] = @user.id
    @user.save
    redirect "/users/#{current_user.id}"
  end

  get '/login' do
    is_logged_in? ? (redirect "/users/#{current_user.id}") : (erb :'/users/sessions/login')
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    elsif User.find(params[:id]).id != session[:user_id]
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/"
    end
  end

  get '/users/:id' do
    if params["id"].to_i > User.count  # If user try to access a different user page.
      flash[:message] = "You are not authorized to access this profile."
      redirect "/users/#{session[:user_id]}"
    else
      @user = User.find(params[:id])
      erb :'users/show'
    end
  end
  
  post '/logout' do
    session.clear
    redirect "/"
  end 
end