class PetController < ApplicationController
  get '/pets' do
    erb :"/pets/index"
  end

  get '/pets/new' do
    erb :'pets/new'
  end

  post '/pets' do # post pets
    if params[:dob].empty?
      flash[:message] = "Birth date required."
      redirect "/pets/new"
    elsif dob_restrict
      redirect "/pets/new"
    end
    !params[:weight].empty? ? params[:weight] += "lbs" : nil
    pet = Pet.new(params)
    pet.user_id = current_user.id
    current_user.pets << pet
    pet.save
    redirect "/pets/#{pet.id}" # CONNECTING USER AND PET
  end

  get '/pets/:id' do
    if !current_user
      redirect "/"
    end
    no_access
    list_pet_vaccinations
    @pet = Pet.find(params[:id])
    erb :'pets/show'
  end

  get '/pets/:id/edit' do
    no_access
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  patch '/pets/:id' do
    dob_restrict
    pet = Pet.find(params[:id])
    !params[:weight].empty? ? pet.weight += "lbs" : nil

    pet.update(name: params[:name], dob: params[:dob], weight: params[:weight], breed: params[:breed], species: params[:species], gender: params[:gender])
    redirect "/pets/#{pet.id}"
  end

  delete '/pets/:id' do
    pet = Pet.find(params[:id])
    pet_name = pet.name
    pet.destroy
    flash[:message] = "Bye, #{pet_name}!"
    redirect "/users/#{current_user.id}"
  end
end