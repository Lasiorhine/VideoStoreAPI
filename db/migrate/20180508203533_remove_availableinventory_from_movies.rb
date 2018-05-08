class RemoveAvailableinventoryFromMovies < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :available_inventory, :integer
  end
end
