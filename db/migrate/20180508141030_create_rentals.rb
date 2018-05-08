class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|

      t.date :check_out_date
      t.date :due_date
      t.date :check_in_date

      t.timestamps
    end
  end
end
