class AdminController < ApplicationController
  before_filter :authenticate_admin!
  def index

  end

  def show_all_rules
    @rules = Rule.all.paginate(:page => params[:page], :per_page => 5)
    render partial: "show_all_rules"
  end

  def show_all_grids
    @grids = Grid.all.paginate(:page => params[:page], :per_page => 5)
    render partial: "show_all_grids"
  end

  def destroy_rule
    params.permit(:id)
    Rule.find(params[:id]).delete
    redirect_to root_path
  end
  def destroy_grid
    params.permit(:id)
    Grid.find(params[:id]).delete
    redirect_to root_path
  end
end
