class VaccineController < ApplicationController
  get '/vaccinations' do
    @vaccinations = Vaccinations.all
  end
  
  get '/vaccinations/new' do
    binding.pry # FIX TO GET PET ID
    erb :'vaccinations/new'
  end


  post '/vaccinations' do
    @vaccination = Vaccination.new(params)
    @vaccination.pet_id = @current_pet_id
    @vaccination.save
    redirect "/pets/#{@current_pet_id}"
  end
end