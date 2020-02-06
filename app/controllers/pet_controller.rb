class PetController < ApplicationController
  get '/pets/new' do
    erb :'pets/new'
  end
  
  post '/pets/new' do # post pets
    @pet = Pet.create(params) # Can't handle
    # @pet = Pet.new(params).save ?????
    @pet.user_id = current_user.id
    @pet.dob.to_date
    @pet.gender.capitalize
    current_user.pets << @pet
    redirect "/users/#{current_user.id}" # CONNECTING USER AND PET
  end

  get '/pets' do
    @pets = Pet.all
    erb :'pets/index'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:name], dob: params[:dob], weight: params[:weight], breed: params[:breed], species: params[:species])
    redirect "/pets/#{@pet.id}"
  end
end