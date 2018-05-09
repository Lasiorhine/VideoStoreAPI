class Movie < ApplicationRecord

  has_many :rentals
  has_many :customers, through: :rentals

  validate :valid_release_date
	validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  def available_inventory
    #Note:  This is a placeholder method, and it's here just so that Movie's show method will serve up the right stuff during early-wave tests.  It will have to evolve in later waves.
    self.inventory
  end

  private

  def valid_release_date
    unless release_date.nil?
      if !release_date.is_a?(Date)
        errors.add(:release_date, "invalid release date")
      end
    end
  end

end
