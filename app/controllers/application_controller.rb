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
      if !current_user.pets.empty?
        current_user.pets.each do |obj| # REMOVE ID FROM SHOW BUT KEEP IN @new_current
          @new_obj = obj.attributes.reject {|pet_attr| pet_attr == "user_id"}
          @pet_objs << @new_obj # Creates new obj without user_id for iterator in view
        end
      end
    end

    def current_pet
      @pet = Pet.find(params["id"])
      @new_current = @pet.attributes.reject {|x| x == "id" || x == "user_id"}
    end

    def list_pet_vaccinations
      pet = Pet.find_by(name: @new_current["name"])
      @pet_vaccinations = []
      if pet.vaccinations.count >= 1
        pet.vaccinations.each do |vacc|
          @current_pet_vacc_id = @pet.id
          # @new_vacc_obj = vacc.attributes.reject {|vacc_attribute| vacc_attribute == "id" || vacc_attribute == "pet_id"}
          @pet_vaccinations << vacc.attributes.reject {|vacc_attribute| vacc_attribute == "id" || vacc_attribute == "pet_id"}
        end
      end
    end
  end
end
