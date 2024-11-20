require 'spec_helper'
require_relative '../lib/ruby_controller'
require_relative '../lib/parkings_controller'
require_relative '../lib/parking'

describe 'RubyController' do
  context '#create' do
    it 'should route to parkings controller' do
      action_controller_params = {
        :"controller" => "parkings",
        :"action" => "create",
        :"params" => { :plate  => "aaa-4444" }
      }
      parkings_controller_stub = double('parkings_controller')
      allow(ParkingsController).to receive(:new).with({ :plate  => "aaa-4444" }).and_return(parkings_controller_stub)
      allow(parkings_controller_stub).to receive(:create)

      RubyController.new(action_controller_params).call

      expect(ParkingsController).to have_received(:new).with({ :plate  => "aaa-4444" })
      expect(parkings_controller_stub).to have_received(:create)
    end
  end
end
