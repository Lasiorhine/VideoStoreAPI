require "test_helper"

describe Movie do

  let(:movie_new) { Movie.new }
  let(:day) { movies(:day)}


  describe "relations" do

    it "has many rentals" do
    end

    it "returns an empty array if it has not been rented" do
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

      #THIS IS A DRAFT TEST.

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

      let(:breakfast) { movies(:breakfast)}

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
