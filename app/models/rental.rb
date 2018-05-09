class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validate :valid_get_check_in_date

  def get_check_out_date
    return created_at.to_date if !created_at.nil?
  end

  def get_due_date
    return get_check_out_date.next_week
  end

  def is_overdue?
    puts is_checked_out?
    puts Date.today > get_due_date
    return is_checked_out? && Date.today > get_due_date
  end

  def is_checked_out?
    return check_in_date.nil?
  end

  # def self.return_rental
  #   raise ArgumentError.new("Not checked out") if !checked_out
  #   checked_out = false
  #   movie.available_inventory += 1
  # end

private

  def valid_get_check_in_date
    return if check_in_date.nil?
    if check_in_date > Date.today || (!created_at.nil? && check_in_date < get_check_out_date) ||
      # TODO: test these last two!!
      check_in_date < customer.registered_at || check_in_date < movie.release_date
      errors.add(:check_in_date, "Invalid check-in")
    end
  end
end
