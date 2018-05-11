class CustomersController < ApplicationController

	# def index
	# 	customers = Customer.all
	# 	render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone,  :movies_checked_out_count]), status: :ok
	# end

	def index
		customer_info_array = []
		customers = Customer.all
		customers.each do |customer|
			customer_hash = {
				id: customer.id,
				name: customer.name,
				registered_at: customer.registered_at,
				postal_code: customer.postal_code,
				phone: customer.phone,
				movies_checked_out_count: customer.movies_checked_out_count}
			customer_info_array << customer_hash
		end
		render json: customer_info_array.as_json, status: :ok
	end

end
