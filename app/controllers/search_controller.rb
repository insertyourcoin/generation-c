class SearchController < ApplicationController
  def results
    @rule_results = Rule.search(params[:query])
    @grid_results = Grid.search(params[:query])
  end
end
