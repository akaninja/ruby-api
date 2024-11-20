require 'spec_helper'
require_relative '../lib/parking.rb'

describe Parking do
  after(:each) { Parking.clear }

  it 'should create successfully' do
    parking_arguments = { :plate => 'aaa-4444' }
    parking = Parking.new(parking_arguments)

    expect(parking.plate).to eq 'aaa-4444'
    expect(parking.entrance_date).to eq Date.today.to_s
    expect(parking.departure_date).to eq ''
  end

  it 'should update departure date successfully' do
    parking_arguments = { :plate => 'aaa-4444' }
    parking = Parking.new(parking_arguments)
    parking.checkout

    expect(parking.plate).to eq 'aaa-4444'
    expect(parking.departure_date).to eq Date.today.to_s
  end

  it 'should list all parkings' do
    parking = Parking.new({ :plate => 'aaa-4444' })
    other_parking = Parking.new({ :plate => 'aaa-5555' })

    expect(Parking.all).to include parking
    expect(Parking.all).to include other_parking
    expect(Parking.count).to eq 2
  end

  it 'should find parking successfully' do
    Parking.new({ :plate => 'bbb-5555' })
    Parking.new({ :plate => 'ccc-6666' })
    Parking.new({ :plate => 'aaa-4444' })

    parking = Parking.find_by(plate: 'ccc-6666')

    expect(parking.plate).to eq 'ccc-6666'
    expect(parking.class).to eq Parking
  end
end
