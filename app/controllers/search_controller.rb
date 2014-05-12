class SearchController < ApplicationController
  before_action :authenticate_user!
  def results
    @rule_results = Rule.search(params[:query])
    @grid_results = Grid.search(params[:query])
  end
end
