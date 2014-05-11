class GridsController < ApplicationController
  def index
    @grids = Grid.where(user_id: current_user.id)
  end
  def new
    @grid = Grid.new
  end
  def create
    params.require(:grid)
    params.permit(:name, :desc);
    grid = params[:grid]
    new_grid = Grid.create(name: :name, description: :desc, user_id: current_user.id)
    if new_grid.valid?
      params[:grid].each do |cell|
        x = cell[1][:column]
        y = cell[1][:row]
        Coord.create(x: x, y: y, grid_id: new_grid[:id])
      end
    else
      respond_to do |format|
        @message = grid.errors.full_messages.to_sentence
        format.js { render 'test' }
      end
    end
  end

  def add
    params.require(:id)
    grid = Grid.where(id: params[:id]).first
    Grid.create(name: grid[:name], description: grid[:description], user_id: current_user.id)
    coords = Coord.where()
  end
end
