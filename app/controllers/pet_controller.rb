class PetController < ApplicationController
  get '/pets' do
    erb :"/pets/index"
  end

  get '/pets/new' do
    erb :'pets/new'
  end

  post '/pets' do # post pets
    if params[:dob].empty? || params[:name].empty? # Overrides 404 error handling
      flash[:message] = "Name and birth date required."
      redirect "/pets/new"
    elsif dob_restrict
      redirect "/pets/new"
    end
    !params[:weight].empty? ? params[:weight] += "lbs" : nil # Concatenate weight and "lbs" || if input empty = N/A
    pet = Pet.new(params)
    pet.user_id = current_user.id
    pet.save
    redirect "/pets/#{pet.id}"
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
    pet.update(name: params[:name], dob: params[:dob], weight: params[:weight] += "lbs", breed: params[:breed], species: params[:species], gender: params[:gender])
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