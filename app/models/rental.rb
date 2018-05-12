class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validate :valid_get_check_in_date

  # Returns the rental checkout date as a Date.
  def get_check_out_date
    return created_at.to_date
  end

  # Returns the rental due date as a Date.
  def get_due_date
    return get_check_out_date.next_week
  end

  # Returns 'true' if rental is overdue, meaning due date was at least one day ago.
  # Otherwise, returns 'false'.
  def is_overdue?
    return is_checked_out? && !get_due_date.future?
  end

  # Returns 'true' if rental is checked out. Otherwise, returns 'false'.
  def is_checked_out?
    return check_in_date.nil?
  end

  # PRE: Throws ArgumentError if rental is already checked out.
  # Sets check_in_date to the current date.
  def return_rental
    if !is_checked_out?
      raise ArgumentError.new("Cannot return an item that isn't checked out")
    else
      self.check_in_date = Date.current
    end
  end

  private

  # Adds an error message if check_in_date is:
  #   1) not nil,
  #   2) not a Date,
  #   3) after today,
  #   4) after checkout date (only if created_at is not nil),
  #   5) after when the customer registered, or
  #   6) after the movie release date
  def valid_get_check_in_date
    return if check_in_date.nil?
    if !check_in_date.is_a?(Date) || (check_in_date.future? ||
      (!created_at.nil? && check_in_date < get_check_out_date) ||
      check_in_date < customer.registered_at ||
       check_in_date < movie.release_date )
      errors.add(:check_in_date, "Invalid check-in")
    end
  end

end
