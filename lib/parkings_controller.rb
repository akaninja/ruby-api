class ParkingsController
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create
    parking = Parking.new(parkings_params)

    return parking.to_json
  end

  def checkout
    parking = Parking.find_by(parkings_params)
    parking.checkout

    return parking.to_json
  end

  private

  def parkings_params
    params.select { |k, v| k.eql?(:plate) }
  end
end
