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

    # registered_at ------------------------------------------------------------
    it "must not validate with an invalid registered_at" do
      info[:registered_at] = nil
      customer = Customer.create(info)
      customer.valid?.must_equal false
      customer.errors.keys.must_equal [:registered_at]

      info[:registered_at] = DateTime.now + 1
      Customer.create(info).valid?.must_equal false

      info[:registered_at] = "foo"
      Customer.create(info).valid?.must_equal false
    end

    it "must allow registered_at today or before" do
      info[:registered_at] = DateTime.now
      Customer.create(info).valid?.must_equal true

      info[:registered_at] = DateTime.yesterday
      Customer.create(info).valid?.must_equal true
    end

  end # end of describe "validate"
end
