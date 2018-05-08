class Customer < ApplicationRecord

 	validates :name, presence: true
	validate :date_in_future_or_error
	validates :address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :postal_code, presence: true
	validates :phone, presence: true

	private

	def date_in_future_or_error
		if registered_at.nil? || registered_at > DateTime.now
			# TODO: needed? || (!created_at.nil?  && registered_at > created_at)
			errors.add(:registered_at, "Invalid registration date")
		end
	end

end
