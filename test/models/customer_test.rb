require "test_helper"

describe Customer do

  # VALIDATE ===================================================================
  describe "validate" do
    let(:customer) { customers(:ada) }
    let(:info) {
      {
        name: "Kathryn",
        registered_at: "Wed, 16 Apr 2017 21:40:20 -0700",
        address: "321 Foo Street",
        city: "Seattle",
        state: "Washington",
        postal_code: "12345",
        phone: "(206) 123-4567"
      }
    }

    # general ------------------------------------------------------------------
    it "must be valid" do
      customers(:ada).must_be :valid?
    end

    it "must respond correctly after validation" do
      customer.must_respond_to :name
      customer.name.must_equal customers(:ada).name

      customer.must_respond_to :registered_at
      customer.registered_at.must_equal customers(:ada).registered_at

      customer.must_respond_to :address
      customer.address.must_equal customers(:ada).address

      customer.must_respond_to :city
      customer.city.must_equal customers(:ada).city

      customer.must_respond_to :state
      customer.state.must_equal customers(:ada).state

      customer.must_respond_to :postal_code
      customer.postal_code.must_equal customers(:ada).postal_code

      customer.must_respond_to :phone
      customer.phone.must_equal customers(:ada).phone
    end

    # name ---------------------------------------------------------------------
    it "must not validate with an invalid name" do
      info[:name] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:name]

      info[:name] = "   "
      Customer.create(info).valid?.must_equal false

      info[:name] = ""
      Customer.create(info).valid?.must_equal false
    end

    it "must allow duplicate name" do
      info[:name] = customers(:ada).name
      Customer.create(info).valid?.must_equal true
    end

    it "must allow name of one character" do
      info[:name] = "a"
      Customer.create(info).valid?.must_equal true
    end

    # registered_at ------------------------------------------------------------
    it "must not validate with an invalid registered_at" do
      info[:registered_at] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:registered_at]

      info[:registered_at] = DateTime.current + 1
      Customer.create(info).valid?.must_equal false

      info[:registered_at] = "foo"
      Customer.create(info).valid?.must_equal false
    end

    it "must allow registered_at today or before" do
      info[:registered_at] = DateTime.current
      Customer.create(info).valid?.must_equal true

      info[:registered_at] = DateTime.yesterday
      Customer.create(info).valid?.must_equal true
    end

    # address ------------------------------------------------------------------
    it "must not validate with an invalid address" do
      info[:address] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:address]

      info[:address] = "   "
      Customer.create(info).valid?.must_equal false

      info[:address] = ""
      Customer.create(info).valid?.must_equal false
    end

    it "must allow address of one character" do
      info[:address] = "a"
      Customer.create(info).valid?.must_equal true
    end

    # city ---------------------------------------------------------------------
    it "must not validate with an invalid city" do
      info[:city] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:city]

      info[:city] = "   "
      Customer.create(info).valid?.must_equal false

      info[:city] = ""
      Customer.create(info).valid?.must_equal false
    end

    it "must allow city of one character" do
      info[:city] = "a"
      Customer.create(info).valid?.must_equal true
    end

    # state ---------------------------------------------------------------------
    it "must not validate with an invalid state" do
      info[:state] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:state]

      info[:state] = "   "
      Customer.create(info).valid?.must_equal false

      info[:state] = ""
      Customer.create(info).valid?.must_equal false
    end

    it "must allow state of one character" do
      info[:state] = "a"
      Customer.create(info).valid?.must_equal true
    end

    # postal_code --------------------------------------------------------------
    it "must not validate with an invalid postal_code" do
      info[:postal_code] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:postal_code]

      info[:postal_code] = "   "
      Customer.create(info).valid?.must_equal false

      info[:postal_code] = ""
      Customer.create(info).valid?.must_equal false
    end

    it "must allow postal_code of one character" do
      info[:postal_code] = "1"
      Customer.create(info).valid?.must_equal true
    end

    # phone --------------------------------------------------------------------
    it "must not validate with an invalid phone" do
      info[:phone] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:phone]

      info[:phone] = "   "
      Customer.create(info).valid?.must_equal false

      info[:phone] = ""
      Customer.create(info).valid?.must_equal false
    end

    it "must allow phone of one character" do
      info[:phone] = "2"
      Customer.create(info).valid?.must_equal true
    end

  end # end of describe "validate"

  describe "methods" do

    let(:ada) { customers(:ada) }
    let(:grace) { customers(:grace) }
    let(:dorothy) { customers(:dorothy) }
    let(:heddy) { customers(:heddy) }

    describe "movies_checked_out_count" do

      it "must return zero for a customer who has never checked out a movie" do

        heddy.movies_checked_out_count.must_equal 0
      end

      it "returns zero for a customer who has checked out movies in the past, but who has no current, open rentals." do

        dorothy.movies_checked_out_count.must_equal 0
      end

      it "returns the currect number for a customer who has checked out movies in the past, and who has  current, open rentals" do

        ada.movies_checked_out_count.must_equal 3

      end

      it "returns the currect number for a customer who has one or more current, open rentals, but who has never returned anything" do

        grace.movies_checked_out_count.must_equal 1

      end

    end

  end
end
