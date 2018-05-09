class Movie < ApplicationRecord

  has_many :rentals
  has_many :customers, through: :rentals

  validate :valid_release_date
	validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  def available_inventory
    all_rentals = self.rentals
    open_rental_count = 0
    if all_rentals.count == 0
      return self.inventory
    else
      all_rentals.each do |rental|
        if rental.check_in_date == nil
          open_rental_count += 1
        end
      end
    end
    available = self.inventory - open_rental_count
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
