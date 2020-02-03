class UserController < ApplicationController
  
  get '/users/new' do
    erb :'users/new'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/"
    end
  end


  post '/users' do
    @user = User.create(params)
    redirect "/users/#{@user.id}"
  end

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  get '/users/:id' do
    if User.find(params[:id]).id != session[:user_id]
      flash[:message] = "You are not authorized to access this profile."
      redirect "/users/#{session[:user_id]}"
    else
      # @pets = Pet.all
      @user = User.find(params[:id])
      erb :'users/show'
    end
  end

  post '/logout' do
    session.clear
    redirect "/"
  end 
end