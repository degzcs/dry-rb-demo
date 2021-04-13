class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :number
      t.integer :number_of_beds
    end
  end
end
