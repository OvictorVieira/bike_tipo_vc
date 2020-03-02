class Api::V1::StationsController < Api::V1::ApplicationController

  def index
    stations = StationRepository.all

    render json: stations, status: :ok, each_serializer: StationSerializer
  end
end