class PetController < ApplicationController
  post '/pets/new' do
    @pet = Pet.create(params)
    @pet.user_id = current_user.id
    current_user.pets << @pet
    redirect "/users/#{current_user.id}" # CONNECTING USER AND PET
  end

  get '/pets' do
    @pets = Pet.all
    erb :'pets/index'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb '/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/show'
  end
end