require 'time'

class Parking
  attr_reader :plate, :entrance_date, :departure_date
  attr_writer :entrance_date

  @@parkings = []

  def initialize(parking_arguments)
    @plate = parking_arguments[:plate]
    @entrance_date = Date.today.to_s
    @departure_date = ''
    @@parkings << self
  end

  def self.find_by(search_params)
    search_params = search_params.to_a[0]
    @@parkings.each { |parking| return parking if parking.send(:"#{search_params[0]}") == search_params[1]}
    nil
  end

  def self.count
    @@parkings.count
  end

  def self.all
    @@parkings
  end

  def self.clear
    @@parkings = []
  end

  def checkout
    @departure_date = Date.today.to_s
  end

  def to_json
     {
       :plate => plate,
       :entrance_date => entrance_date,
       :departure_date => departure_date
     }
  end
end
