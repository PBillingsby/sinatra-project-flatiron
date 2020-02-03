class CreateVaccinations < ActiveRecord::Migration
  def change
    create_table :vaccinations do |t|
      t.string :vacc_type
      t.integer :shot_frequency
      t.datetime :date_administered
      t.boolean :shot_overdue
    end
  end
end
