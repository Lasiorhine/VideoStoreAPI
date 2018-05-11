class Customer < ApplicationRecord
	has_many :rentals
	has_many :movies, through: :rentals

 	validates :name, presence: true
	validate :date_in_future_or_error
	validates :address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :postal_code, presence: true
	validates :phone, presence: true

	def movies_checked_out_count
		all_rentals = self.rentals
		open_rentals_count = 0
		if all_rentals.count == 0
			return 0
		else
			all_rentals.each do |rental|
				if rental.check_in_date == nil
					open_rentals_count += 1
				end
			end
		end
		return open_rentals_count
	end

	private

	def date_in_future_or_error
		if registered_at.nil? || registered_at > DateTime.current
			# TODO: needed? || (!created_at.nil?  && registered_at > created_at)
			errors.add(:registered_at, "Invalid registration date")
		end
	end

end
