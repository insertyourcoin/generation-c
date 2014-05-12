class SearchController < ApplicationController
  before_action :authenticate_user!
  def results
    @@query = params[:query]

  end

  def show_rule_results
    @rules = Rule.search(@@query)
    render partial: "show_rule_results"
  end
  def show_grid_results
    @grids = Grid.search(@@query)
    render partial: "show_grid_results"
  end
end
