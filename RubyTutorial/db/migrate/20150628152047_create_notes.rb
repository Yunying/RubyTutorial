class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :contect
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps null: false
    end
  end
end
