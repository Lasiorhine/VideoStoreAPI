class Customer < ApplicationRecord
 	validates :name, presence: true
	# validates :registered_at
	# validates :address
	# validates :city
	# validates :state
	# validates :postal_code
	# validates :phone
end
