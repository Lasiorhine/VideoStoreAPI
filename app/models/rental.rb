class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie


  validates :check_in_date, inclusion: { :in => (Date.new(2013,12,31)..Date.today) },
		                        allow_nil: true

  # def self.check_out_date
  #   return created_at.to_date
  # end
  #
  # def self.due_date
  #   return created_at.to_date.next_week
  # end
  #
  # def self.overdue?
  #   return checked_out && DateTime.now > due_date
  # end
  #
  # def self.return_rental
  #   raise ArgumentError.new("Not checked out") if !checked_out
  #   checked_out = false
  #   movie.available_inventory += 1
  # end

private

  def valid_check_in_date
    if !check_in_date.nil? && check_in_date > Date.today
      errors.add(:check_in_date, "Invalid check-in")
    end
  end
end
