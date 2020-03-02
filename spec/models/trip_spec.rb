require 'rails_helper'

RSpec.describe Trip, type: :model do
  context 'validations tests' do
    let(:user) { create(:user, email: 'marcio@gmail.com') }
    let(:bike) { create(:bike) }
    let(:station_sao_paulo) { create(:station) }
    let(:station_da_luz) do
      create(:station, name: 'Estação da Luz',
                       latitude: -22.2232155,
                       longitude: -49.9879748)
    end

    let(:trip) do
      create(:trip, user: user,
                    bike: bike,
                    origin_station: station_sao_paulo.id,
                    destination_station: station_da_luz.id)
    end

    it "is valid with valid attributes" do
      expect(trip).to be_valid
    end

    it "is valid without a destination_station" do
      trip.destination_station = nil

      expect(trip).to be_valid
    end

    it "is not valid without a user" do
      trip.user = nil

      expect(trip).to_not be_valid
    end

    it "is not valid without a bike" do
      trip.bike = nil

      expect(trip).to_not be_valid
    end

    it "is not valid without a started_at" do
      trip.started_at = nil

      expect(trip).to_not be_valid
    end

    it "is valid without a finished_at" do
      trip.finished_at = nil

      expect(trip).to be_valid
    end

    it "is not valid without a origin_station" do
      trip.origin_station = nil

      expect(trip).to_not be_valid
    end

    it "is valid without a traveled_distance" do
      trip.traveled_distance = nil

      expect(trip).to be_valid
    end
  end

  context 'test relationship of stations' do
    let(:user) { create(:user, email: 'marcela@gmail.com') }
    let(:bike) { create(:bike) }
    let(:station_sao_paulo) { create(:station) }
    let(:station_da_luz) do
      create(:station, name: 'Estação da Luz',
             latitude: -22.2232155,
             longitude: -49.9879748)
    end

    let(:trip) do
      create(:trip, user: user,
             bike: bike,
             origin_station: station_sao_paulo.id,
             destination_station: station_da_luz.id)
    end

    it 'returns station on load_origin_station method call' do
      origin_station = trip.load_origin_station

      expect(origin_station).to be_present
    end

    it 'returns station on load_destination_station method call' do
      origin_station = trip.load_destination_station

      expect(origin_station).to be_present
    end

  end
end