class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :overview
      t.date :release_date
      t.integer :inventory

      t.timestamps
    end
  end
end
