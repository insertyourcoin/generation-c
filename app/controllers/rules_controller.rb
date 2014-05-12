class RulesController < ApplicationController
  before_action :authenticate_user!
  def new
    @rule = Rule.new
  end

  def create
    rule = params[:rule]
    turn_on = turn_on_string_from_params
    turn_off = turn_off_string_from_params
    if Rule.create(name: rule[:name], description: rule[:description], user_id: current_user.id, turn_on: turn_on, turn_off: turn_off).valid?
      redirect_to rules_path
    else
      redirect_to new_rule_path, flash: {error: "Check out name and description fields, they're optional!"}
    end
  end

  def user_rules
    @rules = Rule.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 3)
    render partial: "user_rules"
  end

  def shared_rules
    @rules = Rule.where(user_id: 0).paginate(:page => params[:page], :per_page => 3)
    render partial: "shared_rules"
  end

  def index

  end

  def show

  end

  def error

  end

  def edit
    rule = Rule.find(params[:id])
    if(current_user.id != rule[:user_id])
      redirect_to rules_error_path
    else
      @rule = rule
    end
  end

  def destroy
    rule = Rule.find(params[:id])
    if(current_user.id != rule[:user_id])
      redirect_to rules_error_path
    else
      rule.delete
      redirect_to root_path
    end
  end

  def turn_on_string_from_params
    turn_on = String.new("000000000")
    9.times do |i|
      turn_on[i] = '1' if params["alive_#{i}"]
    end
    turn_on
  end

  def turn_off_string_from_params
    turn_off = String.new("000000000")
    9.times do |i|
      turn_off[i] = '1' if params["dead_#{i}"]
    end
    turn_off
  end

  def update
    params.require(:rule).permit!
    rule = params[:rule]
    turn_on = turn_on_string_from_params
    turn_off = turn_off_string_from_params
    if Rule.find(params[:id]).update(name: rule[:name], description: rule[:description], turn_on: turn_on, turn_off: turn_off)
      redirect_to rules_path
    else
      redirect_to edit_rule_path(params[:id]), flash: {error: "Check out name and description fields, they're optional!"}
    end
  end

  def add
    params.require(:id)
    rule = Rule.where(id: params[:id]).first
    Rule.create(name: rule[:name], description: rule[:description], turn_on: rule[:turn_on], turn_off: rule[:turn_off], user_id: current_user.id)
  end

end
