class ChangeRentalModel < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :due_date, :date
    remove_column :rentals, :check_out_date, :date
  end
end
