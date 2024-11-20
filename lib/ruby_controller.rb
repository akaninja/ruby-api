require_relative 'home_controller'

class RubyController
  attr_reader :action_controller_params

  def initialize(action_controller_params)
    @action_controller_params = action_controller_params
    set_action_controller_params
  end

  def call
    eval("#{@controller}.new(@params).#{@action}")
  end

  private

  def set_action_controller_params
    @controller = action_controller_params[:controller].capitalize! + "Controller"
    @action = action_controller_params[:action]
    @params = action_controller_params[:params]
  end
end
