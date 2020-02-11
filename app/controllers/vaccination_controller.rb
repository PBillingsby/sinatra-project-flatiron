class VaccinationController < ApplicationController
  get '/vaccinations' do
    @vaccinations = Vaccination.all
  end
  
  get '/vaccinations/new' do
    @current_pet = Pet.find(params["current_pet_id"])
    erb :'vaccinations/new'
  end

  post '/vaccinations' do
    if params[:vacc_name].empty? || params[:date_given].empty?
      flash[:message] = "Name and date required." #TEST
      redirect "vaccinations/new?current_pet_id=#{params["current_pet"]}"
    elsif params["date_given"].to_date > Time.now.to_date
      flash[:message] = "Date given must be earlier than #{Time.now.to_date.strftime("%m/%d/%Y")}" # Handles if date given later than Time.now
      redirect "vaccinations/new?current_pet_id=#{params["current_pet"]}"
    end
    @vaccination = Vaccination.new(vacc_name: params[:vacc_name], vacc_type: params[:vacc_type], date_given: params[:date_given], notes: params[:notes], frequency: params[:frequency], pet_id: params["current_pet"])
    @vaccination.save
    redirect "/pets/#{params["current_pet"]}"
  end

  delete '/vaccinations/:id' do
    vaccination = Vaccination.find(params["id"])
    flash[:message] = "#{vaccination["vacc_name"].capitalize} vaccination record has been deleted."
    vaccination.destroy
    redirect "/pets/#{params["pet_param"]}"
  end
end