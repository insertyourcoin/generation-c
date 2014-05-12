class AdminController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @rules = Rule.all.paginate(:page => params[:page], :per_page => 10)
    @grids = Grid.all
  end
  def destroy_rule

  end
  def destroy_grid

  end
end
