class Customer < ApplicationRecord
 	validates :name, presence: true
	validate :date_in_future_or_error

	# validates :address
	# validates :city
	# validates :state
	# validates :postal_code
	# validates :phone


	private

	def date_in_future_or_error
		if registered_at.nil? || registered_at > DateTime.now
			# TODO: needed? || (!created_at.nil?  && registered_at > created_at)
			errors.add(:registered_at, "Invalid registration date")
		end
	end

end
