require "test_helper"

describe Movie do

  let(:movie_new) { Movie.new }

  let(:day) { movies(:day)}
  let(:breakfast) { movies(:breakfast)}
  let(:get) { movies(:get)}

  let(:ada) {customers(:ada)}
  let(:grace) {customers(:grace)}

  let(:ada_get_rental) { rentals(:ada_get)}
  let(:grace_day_rental) { rentals(:grace_day)}
  let(:ada_day_rental) { rentals(:ada_day)}

  describe "relations" do

    it "has many rentals" do

      day.rentals.count.must_equal 2
      day.rentals[0].must_be_instance_of Rental
      day.rentals[0].customer.id.must_equal (customers(:grace).id)
      day.rentals[1].customer.id.must_equal (customers(:ada).id)

    end


    it "has an empty ActiveRecord relation for 'rentals' if it hasn't even been rented" do

      # Validate the test
      day.rentals.wont_be_empty
      get.rentals.wont_be_empty

      #Assert
      breakfast.rentals.must_be_empty

    end

  end

  describe "validations" do

    it "must be valid with expected paramater input" do
      value(day).must_be :valid?
    end

    it "has validation for empty parameters" do
      movie_new.valid?.must_equal false
    end

    it "has validation for title presence" do
      day.title = nil
      day.valid?.must_equal false
      day.errors.messages.must_include :title

      day.title = ""
      day.valid?.must_equal false
      day.errors.messages.must_include :title
    end

    it "has validation for title uniqueness" do
      day_2 = Movie.new({ title: day.title, overview: "The worst, best movie ever", release_date: 1996-07-04, inventory: 1})
      day_2.valid?.must_equal false
      day_2.errors.messages.must_include :title
    end

    it "has validation for release_date presence" do
      day.release_date = nil
      day.valid?.must_equal false
      day.errors.messages.must_include :release_date

      day.release_date = ""
      day.valid?.must_equal false
      day.errors.messages.must_include :release_date
    end

    it "has validation for release_date's status as a Date object" do

      day.release_date = Date.parse("1996-07-04")
      day.valid?.must_equal true
      day.errors.messages.wont_include :release_date
      day.errors.messages.must_be_empty

      day.release_date = "Jooon Forth, ninety-six"
      day.valid?.must_equal false
      day.errors.messages.must_include :release_date

      day.release_date = 2
      day.valid?.must_equal false
      day.errors.messages.must_include :release_date

    end

    it "has validation for inventory presence" do
      day.inventory = nil
      day.valid?.must_equal false
      day.errors.messages.must_include :inventory

      day.inventory = ""
      day.valid?.must_equal false
      day.errors.messages.must_include :inventory
    end

    it "has validation for inventory's status as a postive integer" do

      day.inventory = 2
      day.valid?.must_equal true

      day.inventory = 0
      day.valid?.must_equal true

      day.inventory = "three on-hand"
      day.valid?.must_equal false
      day.errors.messages.must_include :inventory

      day.inventory = 3.1415
      day.valid?.must_equal false
      day.errors.messages.must_include :inventory

      day.inventory = -7
      day.valid?.must_equal false
      day.errors.messages.must_include :inventory

    end

  end

  describe "methods" do

    describe "available_inventory" do

      it "returns the correct figure for a given movie with one or more copies available" do

        day.available_inventory.must_equal 10

      end

      it "returns the correct figure for a given movie with zero copies available" do

        #This version of this test is sort of a place-holder: Once we get checkout mechanisms working in wave 3 and later, it will have to be dramatically redone.

        breakfast.inventory = 0

        breakfast.available_inventory.must_equal 0
      end

    end


  end

end
