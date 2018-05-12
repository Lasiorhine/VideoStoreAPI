require "test_helper"

describe RentalsController do
	let(:rental) { rentals(:ada_day)}
	let(:info) { {
			check_in_date: nil,
		  movie_id: movies(:get).id,
		  customer_id: customers(:ada).id
		}
	}

	describe "checkout" do

		it "have a functional route" do
			post checkout_url, params: info
			must_respond_with :ok
		end

		it "must return JSON" do
			post checkout_url, params: info
			response.header['Content-Type'].must_include 'json'
		end

		it "must return an Array of the correct length" do
			post checkout_url, params: info
			api_response = JSON.parse(response.body)
			new_rental = Rental.all.last

			expected_response = { "id" => new_rental.id,
				"customer_id" => customers(:ada).id,
				"movie_id" => movies(:get).id,
				"due_date" => Date.current.to_date.next_week
			}
			api_response.must_equal expected_response

		end

		# it "returns JSON with exactly the required fields" do
		# 	required_index_keys = %w(id movies_checked_out_count name phone postal_code registered_at )
		# 	get customers_url
		# 	body = JSON.parse(response.body)
		# 	body.each do |customer|
		# 		customer.keys.sort.must_equal required_index_keys
		# 	end
		#
		# end

	end

	describe "checkin" do

		it "have a functional route" do
			post checkin_url, params: info
			must_respond_with :ok
		end
		it "must return JSON" do
			post checkin_url, params: info
			response.header['Content-Type'].must_include 'json'
		end
	end
end
