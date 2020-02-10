require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secretssafehere'
  end
  get "/" do
    if User.count == 0 || !is_logged_in?
      erb :welcome
    elsif is_logged_in?
      redirect "/users/#{current_user.id}"
    end
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id])
    end

    def current_pet
      pet = Pet.find_by(id: params["id"])
      @new_current = pet.attributes.reject {|x| x == "id" || x == "user_id"} # Creates new object to iterate without id and user_id attributes.
    end

    def list_pet_vaccinations # Dynamic iterator for vaccinations.
      pet = Pet.find_by(id: params["id"])
      @pet_vaccinations = []
      if pet.vaccinations.count != nil
        pet.vaccinations.each do |vacc|
          @pet_vaccinations << vacc.attributes.reject {|vacc_attribute| vacc_attribute == "pet_id"}
        end
      end
    end

    def no_access # Handles user accessing pet that does not belong to them.
      if !current_user.pets.include?(Pet.find_by(id: params[:id]))
        flash[:message] = "You are not authorized to access this profile."
        redirect "/users/#{current_user.id}"
      end
    end

    def new_user_handling # New user bad input handling.
      if params["password"] == params["password2"]
        if params[:password].length < 8
          flash[:message] = "Password must be atleast 8 characters. Try again."
        elsif User.find_by(username: params["username"])
          flash[:message] = "Username taken. Try again."
        elsif User.find_by(email: params[:email])
          flash[:message] = "Email taken. Try again."
        elsif @user.save
          session[:user_id] = @user.id
          redirect "/users/#{current_user.id}"  
        else
          flash[:message] = "Email not valid. Try again."
        end
        redirect "/new"
      else
        flash[:message] = "Both passwords must match"
        redirect "/new"
      end
    end

    def login_handling # User authentication method.
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password]) # Authenticate user.
        session[:user_id] = @user.id
        redirect "/users/#{current_user.id}"
      elsif !params[:id]
        flash[:message] = "Username or password incorrect. Try again." # Handle incorrect login information
        redirect "/login"
      elsif session[:user_id] == current_user.id # Handle if user is already logged in.
        redirect "/users/#{current_user.id}"
      else
        redirect "/"
      end
    end

    def dob_restrict
      if Time.strptime(params["dob"], "%m/%d/%Y").to_date > Time.now.to_date
        flash[:message] = "Date of birth must be earlier than #{Time.now.to_date.strftime("%m/%d/%Y")}" # Handles if date given later than Time.now
      end
    end
  end
end
