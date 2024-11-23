require 'spec_helper'
require 'json'
require_relative '../lib/parking.rb'
require_relative '../lib/parkings_controller.rb'

describe 'ParkingsController' do
  after(:each) { Parking.clear }

  context '#create' do
    it 'returns plate json' do
      params = { :plate  => "aaa-4444" }
      parking_json = ParkingsController.new(params).create

      expect(parking_json[:body][:plate]).to eq 'aaa-4444'
      expect(parking_json[:body][:entrance_date]).to eq Date.today.to_s
    end
  end

  context '#checkout' do
    it 'returns plate json and checkout date' do
      params = { :plate  => "aaa-4444" }
      parking = Parking.new(params)
      parking.entrance_date = "2023-11-11"
      parking_json = ParkingsController.new(params).checkout

      expect(parking_json[:body][:plate]).to eq 'aaa-4444'
      expect(parking_json[:body][:entrance_date]).to eq '2023-11-11'
      expect(parking_json[:body][:departure_date].to_s).to eq Date.today.to_s
    end
  end
end
