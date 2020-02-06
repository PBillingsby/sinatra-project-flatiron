class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.text :dob
      t.string :gender
      t.string :species
      t.string :weight
      t.string :breed
      t.integer :user_id
    end
  end
end