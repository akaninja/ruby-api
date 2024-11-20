require 'socket'
require 'time'
require_relative 'parkings_controller'
require_relative 'ruby_router'
require_relative 'request_parser'
require_relative 'ruby_controller'

class RubyServer
  def initialize(ip, port)
    @ip = ip
    @port = port
    @server = TCPServer.open(ip, port)
    @connection
  end

  def open
    puts 'Abrindo servidor'

    while @connection = @server.accept
      puts 'Conexão iniciada'
      # p @connection.readpartial(2048)
      request = RequestParser.new(@connection.readpartial(2048)).parse
      controller_params = RubyRouter.new(request).call
      response = {
        :"headers" => {
          :"content-type" => "application/json; charset=utf-8",
          :"date" => Date.today.to_s, 
        },
        :"body" =>  RubyController.new(controller_params).call
      }

      @connection.write(response)
      @connection.write("\n")
      @connection.close
    end
  end
end
