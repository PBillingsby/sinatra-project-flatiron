class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.integer :weight
      t.string :breed
      t.integer :user_id
    end
  end
end
