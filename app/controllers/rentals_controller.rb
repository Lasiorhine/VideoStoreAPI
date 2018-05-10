class RentalsController < ApplicationController

	def checkout
		rental = Rental.create(rental_params)
		if rental.valid?
			render json: {
				id: rental.id,
				due_date: rental.get_due_date,
				checked_out?: rental.is_checked_out?,
				overdue?: rental.is_overdue?
				}, status: :ok
		else
			render json: { errors: rental.errors.messages },
			status: :bad_request
		end
	end

	def checkin
		rental = Rental.find_by(customer_id: params["customer_id"], movie_id: params["movie_id"])
		if rental
			rental.return_rental
			if rental.save
				render json: {id: rental.id}, status: :ok
			else
				render json: { errors: rental.errors.messages },
				status: :bad_request
			end
		else
			render json: {ok: false, errors: "Rental not found"}, status: :not_found
		end
	end

	private
	def rental_params
		params.require(:rental).permit(:id, :check_in_date, :movie_id, :customer_id)
	end
end
