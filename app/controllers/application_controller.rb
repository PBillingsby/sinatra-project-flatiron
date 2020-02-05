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
      new_arr = []
      current_user.pets.each do |obj|
        new_arr << obj.attributes.reject {|x| x == "id" || x == "user_id"}.select {|x| x}
        new_arr.each do |k|
          k.each do |k, v|
            if v == "" || v == nil
              v = "N/A"
            end
          end
        end
      end
      binding.pry
      new_arr
    end
  end
end
