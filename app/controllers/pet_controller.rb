class PetController < ApplicationController
  post '/pets/new' do
    @pet = Pet.create(params)
    @pet.user_id = current_user.id
    current_user.pets << @pet
    redirect "/users/#{current_user.id}" # CONNECTING USER AND PET
  end
end