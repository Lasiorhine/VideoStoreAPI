class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validate :valid_check_in_date

  def check_out_date
    return created_at.to_date
  end

  def due_date
    return created_at.to_date.next_week
  end

  def is_overdue?
    return checked_out? && Date.today > due_date
  end

  def is_checked_out?
    return check_out_date.nil?
  end
  #
  # def self.return_rental
  #   raise ArgumentError.new("Not checked out") if !checked_out
  #   checked_out = false
  #   movie.available_inventory += 1
  # end

private

  def valid_check_in_date
    return if check_in_date.nil?
    if check_in_date > Date.today || (!created_at.nil? && check_in_date < created_at.to_date) ||
      # TODO: test these last two!!
      check_in_date < customer.registered_at || check_in_date < movie.release_date
      errors.add(:check_in_date, "Invalid check-in")
    end
  end
end
