class AddCustomerToRentals < ActiveRecord::Migration[5.1]
  def change
    add_reference :rentals, :customer, foreign_key: true
  end
end
