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
      current_user.pets.each do |obj|
        @new_obj = obj.attributes.reject {|pet_attr| pet_attr == "id" || pet_attr == "user_id"}.select {|x| x}
      end
      
      # new_arr = []
      # current_user.pets.each do |obj|
      #   obj.attributes.each do |k, v|
      #     if k.attributes == "" || v == nil
      #      v = "N/A"
      #     end
      #   end
      #   new_arr << obj.attributes.reject {|x| x == "id" || x == "user_id"}.select {|x| x}
      # end
      # new_arr
    end
  end
end
