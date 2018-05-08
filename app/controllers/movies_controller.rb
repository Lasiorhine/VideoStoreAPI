class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render :json => movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: )
    render :json => movies.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
  end

  def create
  end

  private

  def user_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end


title
overview
release_date
inventory (total)
available_inventory
