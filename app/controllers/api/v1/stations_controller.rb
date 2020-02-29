class Api::V1::StationsController < ApplicationController

  def index
    stations = StationRepository.all

    render json: stations, status: :ok, each_serializer: StationSerializer
  end
end