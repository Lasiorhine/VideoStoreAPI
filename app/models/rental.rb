class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :checked_out, inclusion: { in: [true, false] },
                          exclusion: { in: [nil] }

  def self.check_out_date
    return created_at.to_date
  end

  def self.due_date
    return created_at.to_date.next_week
  end

  def self.overdue?
    return checked_out && DateTime.now > due_date
  end

  def self.return_rental
    raise ArgumentError.new("Not checked out") if !checked_out
    checked_out = false
    movie.available_inventory += 1
  end

end
