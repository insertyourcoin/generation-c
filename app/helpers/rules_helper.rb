module RulesHelper
  def turn_on_string_from_params
    params.require(:rule).permit!
    rule = params[:rule]
    turn_on = String.new("000000000")
    9.times do |i|
      turn_on[i] = '1' if params["alive_#{i}"]
    end
    turn_on
  end
  def turn_off_string_from_params
    params.require(:rule).permit!
    rule = params[:rule]
    turn_off = String.new("000000000")
    9.times do |i|
      turn_off[i] = '1' if params["dead_#{i}"]
    end
    turn_off
  end
end
