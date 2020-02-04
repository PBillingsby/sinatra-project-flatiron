class UserController < ApplicationController
  
  get '/new' do
    erb :'registrations/new'
  end

  get '/login' do
    is_logged_in? ? (redirect "/users/#{current_user.id}") : (erb :'sessions/login')
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
    @user = User.create(params) # User.new
    session[:user_id] = @user.id
    current_user = @user
    redirect "/users/#{current_user.id}"
  end

  get '/users/:id' do
    if User.find(params[:id]).id != session[:user_id] # If user try to access a different user page.
      flash[:message] = "You are not authorized to access this profile."
      redirect "/users/#{session[:user_id]}"
    else

      @user = User.find(params[:id])
      erb :'users/show'
    end
  end

  # get '/users/:id/edit' do
  #   if current_user.id != params[:id].to_i
  #     flash[:message] = "You are not authorized to access this profile."
  #     redirect "/users/#{session[:user_id]}"
  #   end
  #   # @pets = Pet.all <-- May not need instance variable.
  #   @user = User.find(params[:id])
  #   erb :'users/edit'
  # end
  # patch '/users/:id' do
  #   @user = User.find(params[:id])
  #   params["user"]["pet_ids"].each do |num|
  #     @pet = Pet.find(num.to_i)
  #     @pet.user_id = @user.id
  #   end
  #   @user.update(params[:user][:name])
  # end
  post '/logout' do
    session.clear
    redirect "/"
  end 
end