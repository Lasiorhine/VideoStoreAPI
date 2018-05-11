

class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render :json => movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if !movie.nil?
      render :json => {
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        release_date: movie.release_date,
        inventory: movie.inventory,
        available_inventory: movie.available_inventory,
        ok: true
      }
    else
        render json: {ok: false}, status: :not_found
    end
  end

  def create
    movie = Movie.create(movie_params)
    if movie.valid?
      render json: {
        id: movie.id,
        ok: true }, status: :ok
    else
      render json: {
        errors: movie.errors.messages,
        ok: false
      }, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
