class VaccinationController < ApplicationController
  get '/vaccinations' do
    @vaccinations = Vaccination.all
  end
  
  get '/vaccinations/new' do
    @current_pet = Pet.find(params[:current_pet_id].to_i)
    erb :'vaccinations/new'
  end


  post '/vaccinations' do
    @vaccination = Vaccination.new(vacc_name: params[:vacc_name], vacc_type: params[:vacc_type], frequency: params[:shot_frequency], description: params[:description])
    @vaccination.date_given = params[:date_given].to_date
    @vaccination.pet_id = params[:current_pet].to_i
    @need_this_to_work = params[:current_pet].to_i
    @vaccination.save
    redirect "/pets/#{params[:current_pet]}"
  end

  delete '/vaccinations/:id/delete' do
    @vaccination = Vaccination.find(params["id"])
    @vaccination.destroy
  end
end