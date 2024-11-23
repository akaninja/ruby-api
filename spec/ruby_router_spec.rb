require 'spec_helper'
require_relative '../lib/ruby_router'

describe 'RubyRouter' do
  context '.call' do
    it 'post to parkings' do
      request = {
        :"method" => 'POST',
        :"path" => '/parkings',
        :"version" => 'HTTP/1.1',
        :"headers" => { :"host" => 'localhost:5678',
                        :"user-agent" =>'curl/7.88.1',
                        :"accept" => '*/*',
                        :"content-type" => 'application/json',
                        :"content-length" => '18' },
                        :"params" => {:"plate"=> "aaa-4444"}
      }
      action_controller_params = {
        :"controller" => "parkings",
        :"action" => "create",
        :params => { :"plate" => "aaa-4444" }
      }
      ruby_router = RubyRouter.new(request).call

      expect(ruby_router).to eq action_controller_params
    end

    it 'put to parkings' do
      request = {
        :"method" => 'PUT',
        :"path" => '/parkings',
        :"version" => 'HTTP/1.1',
        :"headers" => { :"host" => 'localhost:5678',
                        :"user-agent" =>'curl/7.88.1',
                        :"accept" => '*/*',
                        :"content-type" => 'application/json',
                        :"content-length" => '18' },
                        :"params" => {:"plate"=> "aaa-4444"}
      }
      action_controller_params = {
        :"controller" => "parkings",
        :"action" => "checkout",
        :params => { :"plate" => "aaa-4444" }
      }
      ruby_router = RubyRouter.new(request).call

      expect(ruby_router).to eq action_controller_params
    end

    it 'root' do
      request = {
        :"method" => 'GET',
        :"path" => '/',
        :"version" => 'HTTP/1.1',
        :"headers" => { :"host" => 'localhost:5678',
                        :"user-agent" =>'curl/7.88.1',
                        :"accept" => '*/*',
        },
        :"params" => nil
      }
      action_controller_params = {
        :"controller" => "home",
        :"action" => "index"
      }
      ruby_router = RubyRouter.new(request).call

      expect(ruby_router).to eq action_controller_params
    end
  end
end
