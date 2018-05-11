require "test_helper"

describe CustomersController do


	describe "index" do

		it "have a functional route" do
			get customers_url
			must_respond_with :ok
		end

		it "must return JSON" do

			get customers_url
			response.header['Content-Type'].must_include 'json'

		end

		it "must return an Array of the correct length" do

			get customers_url
			body = JSON.parse(response.body)

			body.must_be_kind_of Array
			body.length.must_equal Customer.count

		end

		it "returns JSON with exactly the required fields" do

			required_index_keys = %w(id movies_checked_out_count name phone postal_code registered_at )
			get customers_url
			body = JSON.parse(response.body)
			body.each do |customer|
				customer.keys.sort.must_equal required_index_keys
			end

		end


	end
end
