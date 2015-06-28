class AddZipcodeToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :zipcode, :string
  end
end
