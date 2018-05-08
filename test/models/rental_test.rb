require "test_helper"

describe Rental do
  let(:rental) { rentals(:ada_get) }
  let(:info) {
    {
      check_in_date: "2018-05-07",
      movie: movies(:breakfast),
      customer: customers(:grace)
    }
  }

  # VALIDATION =================================================================
  describe "valid" do
    it "must be valid" do
      rental.must_be :valid?
    end

    it "must respond correctly" do
      rental.must_respond_to :check_in_date
      rental.check_in_date.must_be_nil
    end

    # relationships ------------------------------------------------------------
    it "must have relationships with customer" do
      rental.must_respond_to :customer
      rental.customer.must_equal customers(:ada)
      rental.customer.must_be_kind_of Customer
      rental.customer.movies.must_include rental.movie # through relationship
    end

    it "must have relationships with movie" do
      rental.must_respond_to :movie
      rental.movie.must_equal movies(:get)
      rental.movie.must_be_kind_of Movie
      rental.movie.rentals.must_include rental
      rental.movie.customers.must_include rental.customer # through relationship
    end

    # check_in_date ------------------------------------------------------------
    it "must allow nil check_in_date" do
      info[:check_in_date] = nil
      rental = Rental.create(info)
      rental.must_be :valid?
    end

    it "must allow check_in_date to change from nil" do
      info[:check_in_date] = nil
      rental = Rental.create(info)
      # puts "_____"
      # puts rental.inspect

      rental.update(check_in_date: Date.today)
      rental.must_be :valid?
      # puts rental.errors.inspect
    end

    it "must not allow invalid check_in_date" do
      info[:check_in_date] = Date.tomorrow
      bad_rental = Rental.create(info)
      bad_rental.valid?.must_equal false
      bad_rental.errors.keys.must_equal [:check_in_date]
    end

    it "must not allow invalid check_in_date" do
      info[:check_in_date] = Date.tomorrow
      bad_rental = Rental.new(info)
      bad_rental.valid?.must_equal false
      bad_rental.errors.keys.must_equal [:check_in_date]
    end

  end

end
