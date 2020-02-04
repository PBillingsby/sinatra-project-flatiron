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

    def parse_pet
      current_user.pets.each do |pet_obj|
        pet_obj.attributes.each do |pet_attribute, value|
          if pet_attribute == "id" || pet_attribute == "user_id"
            nil
          elsif pet_attribute == "weight" && !value.blank?
            puts "#{pet_attribute.capitalize}: #{value}"
          elsif !value.blank?
            puts "#{pet_attribute.capitalize}: #{value}"#Dynamic pet show
          end
        end
      end
    end 
  end
end
