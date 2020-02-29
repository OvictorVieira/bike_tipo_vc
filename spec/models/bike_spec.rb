require 'rails_helper'

RSpec.describe Bike, type: :model do
  context 'validations tests' do
    let(:station) { create(:station) }
    let(:bike) { create(:bike, station: station) }

    it "is valid with valid attributes" do
      expect(bike).to be_valid
    end

    it "is not valid without a code" do
      bike.code = nil

      expect(bike).to_not be_valid
    end

    it "is not valid without a station" do
      bike.station_id = nil

      expect(bike).to_not be_valid
    end
  end
end