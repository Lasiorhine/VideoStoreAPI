class RentalsController < ApplicationController

	def checkout
		rental = Rental.create(rental_params)
		if rental.valid?
			render json: {
				id: rental.id,
				due_date: rental.due_date,
				checked_out?: rental.checked_out?,
				overdue?: rental.overdue?
			}, status: :ok
		else
			render json: { errors: rental.errors.messages },
				 status: :bad_request
		end
 	end

 private
	def rental_params
	  params.require(:rental).permit(:check_in_date, :movie_id, :customer_id)
	end
end
