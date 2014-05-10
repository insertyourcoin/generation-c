class GridsController < ApplicationController
  def index
    @grids = Grid.where(user_id: current_user.id)
  end
  def new
    @grid = Grid.new
  end
  def add
    params.require(:id)
    grid = Grid.where(id: params[:id]).first
    Grid.create(name: grid[:name], description: grid[:description], user_id: current_user.id)
  end
end
