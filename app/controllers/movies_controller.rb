class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render :json => movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: )
    if movie
      render :json {
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        release_date: movie.release_date,
        inventory: movie.inventory,
        available_inventory: movie.available_inventory
      }, status: ok
    else
        render json: {ok: false}, status: :not_found
    end
  end

  def create
    movie = Movie.create(rental_params)
    if movie.valid?
      render json: {
        id: movie.id
      }, status: :ok
    else
      render json: { errors: movie.errors.messages },
         status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
