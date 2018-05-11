require "test_helper"

describe MoviesController do

  describe "index" do

		it "must have a functional route" do

      get movies_path
      must_respond_with :ok

		end

    it "must return JSON" do

      get movies_url
      response.header['Content-Type'].must_include 'json'

    end

    it "must return an Array of the correct length" do

      get movies_url
      body = JSON.parse(response.body)

      body.must_be_kind_of Array
      body.length.must_equal Movie.count

    end

    it "returns JSON with exactly the required fields" do
      required_index_keys = %w(id release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal required_index_keys
      end

    end

	end

  describe "show" do

    it "must have a working route" do
      get movie_url(movies(:breakfast).id)
      value(response).must_be :success?
    end

    it "must return JSON" do

      get movie_url(movies(:wanda).id)
      response.header['Content-Type'].must_include 'json'

    end

    it "must return the correct HTTP status messsage for an existing movie" do

      get movie_url(movies(:lights).id)
      must_respond_with :ok

    end

    it "must return the correct collection of JSON fields, which must contain the correct info for the movie " do

      #Arrange/Act
      get movie_url(movies(:once).id)

      #Obtain and organize resulting data
      body = JSON.parse(response.body)

      #Form of JSON outpout must be correct
      body.must_be_kind_of Hash
      body.keys.count.must_equal 7

      #Specific JSON keys must be correct
      required_show_keys = %w(available_inventory id inventory ok overview release_date title)
      body.keys.sort.must_equal required_show_keys

      #Information assigned to the keys must be correct
      body["title"].must_equal "Once Upon a Time in Anatolia"
      body["inventory"].must_equal 1
      body["overview"].must_equal "Want to watch something really long? Here you go!!"

      #The expected information must correspond to what's in the database
      confirm_info_movie = Movie.find_by(title: body["title"])
      confirm_info_movie.id.must_equal movies(:once).id
      confirm_info_movie.inventory.must_equal movies(:once).inventory
      confirm_info_movie.release_date.must_equal movies(:once).release_date

    end

    it "must provide the correct response for a non-existent movie" do

      #Arrange
      unmovie = movies(:backbone)
      unmovie.destroy

      #Act
      get movie_url(movies(:backbone).id)

      #Organize/interpret resulting
      body = JSON.parse(response.body)

      #Assert:
      ### HTTP response must be correct
      must_respond_with :not_found

      ###Form of JSON outpout must be correct
      body.must_be_kind_of Hash
      body.keys.count.must_equal 1
      body.keys.must_include "ok"

      ###Content of JSON output must be correct
      body["ok"].must_equal false

    end

  end

  describe "create" do

    let(:movie_data) {
      {
        title: "Mothlight",
        overview: "Three life-changing minutes of dead moths.",
        release_date: Date.parse('01-01-1963'),
        inventory: 27,
      }
    }

    it "creates a new movie when given complete, valid data" do

      #Arrange
      before_count = Movie.all.count

      #Act
      post movies_path, params: movie_data

      #Assert / Validate test
      must_respond_with :success

      #Gather and organize result data
      after_count = Movie.all.count
      test_movie = Movie.last
      body = JSON.parse(response.body)

      #Assert:
      #The resulting JSON mast have the correct format and baseline content.
      body.must_be_kind_of Hash
      body.wont_include "errors"
      body.keys.count.must_equal 2
      body.keys.must_include "id"
      body.keys.must_include "ok"
      body["ok"].must_equal true
      Movie.find(body["id"]).title.must_equal "Mothlight"

      #A new movie object must be created
      (after_count - before_count).must_equal 1

      #The new object's attributes must contain the correct information.
      test_movie.title.must_equal "Mothlight"
      test_movie.overview.must_equal "Three life-changing minutes of dead moths."
      test_movie.inventory.must_equal 27

    end

    it "does not create a new movie when given incomplete data" do

      movie_data[:title] = nil

      proc {
        post movies_url, params: movie_data
      }.must_change 'Movie.count', 0
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
      body.must_include "ok"
      body["ok"].must_equal false

    end

  end

end
