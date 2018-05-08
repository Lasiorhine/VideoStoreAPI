require "test_helper"

describe CustomersController do
	describe "index" do
		it "must get the index" do
			get customers_path
			must_respond_with :ok
		end
	end
end
