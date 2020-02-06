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
    if is_logged_in?
      redirect "/users/#{current_user.id}"
    else
    erb :welcome
    end 
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end

    def list_user_pets
      @pet_objs = []
      current_user.pets.each do |obj| # REMOVE ID FROM SHOW BUT KEEP IN @new_current
        @new_obj = obj.attributes.reject {|pet_attr| pet_attr == "user_id"}.select {|x| x} # pet_attr == "id" || 
        @pet_objs << @new_obj
      end
    end

    def list_pet_vaccinations
      @vaccinations = Vaccinations.all
    end

    def current_pet

      @current = @pet_objs.detect {|x| x["id"]  == params[:id].to_i}
      @current_id = @current["id"].to_i
      @new_current = @current.reject {|attribute| attribute == "id"}
      
    end
  end
end
