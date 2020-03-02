class Api::V1::BikesController < Api::V1::ApplicationController

  def index
    bikes = BikeRepository.all

    render json: bikes, status: :ok, each_serializer: BikeSerializer
  end
end