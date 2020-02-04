class CreateVaccinations < ActiveRecord::Migration
  def change
    create_table :vaccinations do |t|
      t.string :vacc_type
      t.integer :frequency
      t.datetime :date_given
      t.boolean :overdue
    end
  end
end
