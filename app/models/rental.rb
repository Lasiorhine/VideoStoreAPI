class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  # after_commit :decrease_inventory, on: create

  # First video
  validate :valid_check_in_date

  # validates :check_in_date, inclusion: { in: [true, false] },
                          # exclusion: { in: [nil] }

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

    # def self.decrease_inventory
    #   movie.available_inventory += 1
    # end


    def valid_check_in_date
      if !check_in_date.nil? && check_in_date > Date.today
        errors.add("Invalid check-in")
      end
      errors.add("Cannot change check-in date") if check_in_date
    end


end
