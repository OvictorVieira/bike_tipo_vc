class Api::V1::TripsController < ApplicationController

  before_action :trip_params, only: [:create, :update]

  def index
    trips = TripRepository.all

    render json: trips, each_serializer: TripSerializer
  end

  def show
    begin
      load_trip

      render json: @trip

    rescue ActiveRecord::RecordNotFound

      render json: { message: I18n.t('activerecord.errors.messages.record_not_found') },
             status: :not_found
    end
  end

  def create
    begin
      trip_created = TripCreateCommand
                       .create!(params[:bike_id],
                                params[:user_id],
                                params[:origin_station])

      render json: trip_created, status: :created

    rescue ActiveRecord::RecordInvalid, ActiveRecord::InvalidForeignKey

      render json: { message: I18n.t('activerecord.errors.messages.invalid_fields') },
             status: :unprocessable_entity
    end
  end

  private

    include TripConcern
end