class ParkingsController
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create
    parking = Parking.new(parkings_params)

    return { :body => parking.to_json, :status => 200 }
  end

  def checkout
    parking = Parking.find_by(parkings_params)

    if parking
      parking.checkout
      return { :body => parking.to_json, :status => 200 }
    else
      return { body: {}, status: 406 }
    end
  end

  private

  def parkings_params
    params.select { |k, v| k.eql?(:plate) }
  end
end
