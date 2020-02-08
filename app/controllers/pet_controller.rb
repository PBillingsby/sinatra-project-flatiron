class PetController < ApplicationController
  get '/pets/new' do
    erb :'pets/new'
  end

  post '/pets' do # post pets
    @pet = Pet.new(params) # Can't handle
    @pet.user_id = current_user.id
    @pet.dob.to_date
    @pet.gender.capitalize
    current_user.pets << @pet
    @pet.save
    redirect "/users/#{current_user.id}" # CONNECTING USER AND PET
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @vacc_count = @pet.vaccinations.count
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:name], dob: params[:dob], weight: params[:weight], breed: params[:breed], species: params[:species], gender: params[:gender])
    redirect "/pets/#{@pet.id}"
  end

  delete '/pets/:id' do
    @pet = Pet.find(params[:id])
    pet_name = @pet.name
    @pet.destroy
    flash[:message] = "Bye, #{pet_name}!"
    redirect "/users/#{current_user.id}"
  end
end