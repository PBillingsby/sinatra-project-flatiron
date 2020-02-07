class CreateVaccinations < ActiveRecord::Migration
  def change
    create_table :vaccinations do |t|
      t.string :vacc_name
      t.string :vacc_type
      t.text :description
      t.integer :frequency
      t.text :date_given
      t.integer :pet_id
    end
  end
end
