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

      day.release_date = "July Fourth, ninety-six"
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

    it "has validation for release_date's status as an integer" do

      day.inventory = "three on-hand"
      day.valid?.must_equal false
      day.errors.messages.must_include :inventory

      day.release_date = 3.1415
      day.valid?.must_equal false
      day.errors.messages.must_include :inventory
    end

  end

end
