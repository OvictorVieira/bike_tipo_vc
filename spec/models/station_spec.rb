require 'rails_helper'

RSpec.describe Station, type: :model do
  context 'validations tests' do
    let(:station) { create(:station) }

    it "is valid with valid attributes" do
      expect(station).to be_valid
    end

    it "is not valid without a name" do
      station.name = nil

      expect(station).to_not be_valid
    end

    it "is not valid without a latitude" do
      station.latitude = nil

      expect(station).to_not be_valid
    end

    it "is not valid without a longitude" do
      station.longitude = nil

      expect(station).to_not be_valid
    end
  end
end