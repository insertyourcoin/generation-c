class GameController < ApplicationController
  def show
    params.require(:rule_id)
    params.require(:grid_id)
    params.permit(:rule_id, :grid_id)
    @rule = Rule.where(id: params[:rule_id]).first
    @grid = Coord.all.where(grid_id: params[:grid_id]) if params[:grid_id] != :random
    @mode = "random" if params[:grid_id] == "random"
  end
end
