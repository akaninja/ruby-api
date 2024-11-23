class HomeController
  def initialize(params)
    @params = params
  end

  def index
    return { :body => "Boas vindas ao RubyApi", :status => 200 }
  end
end
