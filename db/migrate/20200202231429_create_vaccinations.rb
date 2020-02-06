class CreateVaccinations < ActiveRecord::Migration
  def change
    create_table :vaccinations do |t|
      t.string :vacc_type
      t.text :description
      t.integer :frequency
      t.datetime :date_given
      t.integer :pet_id
    end
  end
end
