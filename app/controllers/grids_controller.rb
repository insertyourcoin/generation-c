class GridsController < ApplicationController
  before_action :authenticate_user!
  def index
    @grids = Grid.where(user_id: current_user.id)
  end
  def new
    @grid = Grid.new
  end
  def create
    params.require(:grid)
    params.permit(:name, :desc)
    grid = params[:grid]
    new_grid = Grid.create(name: params[:name], description: params[:desc], user_id: current_user.id)
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
    render :js => "window.location = '/?locale=#{I18n.locale}'"
  end

  def edit
    params.require(:id)
    params.permit(:id)

    grid = Grid.find(params[:id])
    if(current_user.id != grid[:user_id])
      redirect_to grids_error_path
    else
      @grid = grid
      @cells = Coord.all.where(grid_id: @grid[:id])
    end

  end

  def error

  end


  def update
    params.permit(:name, :desc, :id)
    Grid.find(params[:id]).update(name: params[:name], description: params[:desc])
    Coord.where(grid_id: params[:id]).each do |coord|
      coord.delete
    end
    coords = params[:grid]
    coords.each do |coord|
      Coord.create(x: coord[1][:column], y: coord[1][:row], grid_id: params[:id])
    end
    render :js => "window.location = '/?locale=#{I18n.locale}'"
  end

  def add
    params.require(:id)
    grid = Grid.where(id: params[:id]).first
    Grid.create(name: grid[:name], description: grid[:description], user_id: current_user.id)
    coords = Coord.where()
  end
end
