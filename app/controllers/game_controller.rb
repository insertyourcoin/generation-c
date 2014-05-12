class GameController < ApplicationController
  before_action :authenticate_user!
  def show
    params.require(:rule_id)
    params.require(:grid_id)
    params.permit(:rule_id, :grid_id)
    @rule = Rule.where(id: params[:rule_id]).first
    @grid = Coord.all.where(grid_id: params[:grid_id]) if params[:grid_id] != :random
    @mode = "random" if params[:grid_id] == "random"
  end

  def jump
    first_line = "x = #{params[:cols]}, y = #{params[:rows]}, rule = B#{params[:b]}/S#{params[:s]}\n"
    path = "golly/input.rle"
    File.open(path, "w+") do |f|
      f.write(first_line)
    end
    File.open(path, "a") do |f|
      f.write(params[:rle])
    end
    answer = system("golly/bgolly -m 1000000 -h -o golly/output.rle golly/input.rle")
    @contents = File.read('golly/output.rle')

    render json: {contents: @contents}
  end

end
