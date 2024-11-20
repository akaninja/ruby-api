require_relative '../lib/parking'

class RubyRouter
  attr_reader :method, :path, :params

  def initialize(request)
    @method = request[:method]
    @path = request[:path].delete_prefix("/")
    @params = request[:params]
  end

  def call
    return post_action_controller if method == "POST"
    return get_action_controller if method == "GET"
    return patch_action_controller if method == "PUT"
  end

  private

  def post_action_controller
    { :"controller" => path, :"action" => "create", :"params" => @params }
  end

  def get_action_controller
    controller = if path.empty?
                   "home"
                 else
                   path
                 end
    { :"controller" => controller, :"action" => "index" }
  end

  def patch_action_controller
    { :"controller" => path, :"action" => "check_out", :"params" => @params }
  end
end
