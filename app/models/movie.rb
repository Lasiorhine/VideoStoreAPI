class Movie < ApplicationRecord

  attr_accessor :available_inventory

  has_many :rentals
  has_many :customers, through: :rentals

	validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def available_inventory
    #Note:  This is a placeholder method, and it's here just so that Movie's show method will serve the right stuff.  It will have to evolve in later waves.

    self.inventory
  end
end
