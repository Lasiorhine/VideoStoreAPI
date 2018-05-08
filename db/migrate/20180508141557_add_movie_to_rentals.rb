class AddMovieToRentals < ActiveRecord::Migration[5.1]
  def change
    add_reference :rentals, :movie, foreign_key: true
  end
end
