require "test_helper"

describe Rental do
  let(:rental) { rentals(:ada_get) }
  let(:info) {
    {
      check_in_date: Date.current,
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
      rental.check_in_date.must_be_nil
    end

    it "must allow check_in_date of today" do
      info[:check_in_date] = Date.today
      rental = Rental.create(info)
      rental.must_be :valid?
      rental.check_in_date.must_equal Date.today
    end

    it "must not allow a number as a date" do
      info[:check_in_date] = 3
      bad_rental = Rental.create(info)
      bad_rental.valid?.must_equal false
      bad_rental.errors.keys.must_equal [:check_in_date]
    end

    it "must not allow check in date after today" do
      info[:check_in_date] = Date.tomorrow
      bad_rental = Rental.create(info)
      bad_rental.valid?.must_equal false
      bad_rental.errors.keys.must_equal [:check_in_date]
    end

    it "must not allow check in date before created_at" do
      rental.update(created_at: "2017-02-04")
      rental.update(check_in_date: "2017-02-03")
      rental.valid?.must_equal false
      rental.errors.keys.must_equal [:check_in_date]
    end

  end # end of VALIDATION

  # GET_CHECK_OUT_DATE =========================================================
  describe "get_check_out_date" do
    it "has a get_check_out_date" do
      rental.must_respond_to :get_check_out_date
    end

    it "has a checkout date that is a Date" do
      rental.get_check_out_date.must_be_kind_of Date
    end

    it "sets its get_check_out_date to be the date created" do
      rental.get_check_out_date.must_equal rental.created_at.to_date
    end
  end

  # GET_DUE_DATE ===============================================================
  describe "get_due_date" do
    it "has a get_due_date" do
      rental.must_respond_to :get_due_date
    end

    it "has a get_due_date date that is a Date" do
      rental.get_due_date.must_be_kind_of Date
    end

    it "sets its get_due_date to be the date created + 1 week" do
      rental.get_due_date.must_equal rental.created_at.to_date.next_week
    end
  end

  # IS_OVERDUE? ================================================================
  describe "is_overdue?" do
    it "has a is_overdue?" do
      rental.must_respond_to :is_overdue?
    end

    it "initializes with is_overdue?" do
      info[:check_in_date] = nil
      new_rental = Rental.create(info)
      new_rental.is_overdue?.must_equal false
    end

    it "is still false on the day it's due" do
      new_rental = Rental.create(info)
      new_rental.update(created_at: new_rental.get_due_date)
      new_rental.is_overdue?.must_equal false
    end

    it "sets to true after a week and one day and checked out" do
      new_rental = Rental.create(info)
      new_rental.update(created_at: Date.yesterday.last_week)
      new_rental.update(check_in_date: nil)
      new_rental.is_overdue?.must_equal true
    end

    it "is not overdue if not checked out" do
      new_rental = Rental.create(info)
      new_rental.update(created_at: Date.yesterday.last_week)
      new_rental.update(check_in_date: Date.current)
      new_rental.is_overdue?.must_equal false
    end
  end

  # IS_CHECKED_OUT? ============================================================
  describe "is_checked_out?" do
    it "has a is_checked_out?" do
      rental.must_respond_to :is_checked_out?
    end

    it "initializes with is_checked_out?" do
      info[:check_in_date] = nil
      new_rental = Rental.create(info)
      new_rental.is_checked_out?.must_equal true
    end

    it "is true when has a return date" do
      new_rental = Rental.create(info)
      new_rental.update(check_in_date: Date.current)
      new_rental.is_checked_out?.must_equal false
    end
  end

  # RETURN_RENTAL ==============================================================
  describe "return_rental" do
    it "return_rental" do
      rental.must_respond_to :return_rental
    end

    it "must lock" do
      created_at_original = rental.created_at
      rental.update(check_in_date: Date.yesterday)
      (created_at_original == rental.created_at).must_equal true
    end

    it "initializes with return_rental" do
      new_rental = Rental.create(info)
      new_rental.return_rental
      new_rental.save
      new_rental.errors.keys.must_equal [:check_out]
    end

    # it "initializes with return_rental" do
    #   # info[:check_in_date] = nil
    #   new_rental = Rental.create(info)
    #   puts "****"
    #   puts new_rental.check_in_date
    #   puts !new_rental.is_checked_out?
    #   new_rental.return_rental
    #   puts new_rental.is_checked_out?
    #   rental.valid?.must_equal false
    #   # new_rental.return_rental.must_equal true
    # end

    # it "is true when has a return date" do
    #   new_rental = Rental.create(info)
    #   new_rental.update(check_in_date: Date.current)
    #   new_rental.return_rental.must_equal false
    # end
  end


end
