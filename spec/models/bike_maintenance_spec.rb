require 'rails_helper'
require_relative '../requests/utils/create_bike_maintenance_mocks'

RSpec.describe BikeMaintenance, type: :model do

  context 'validations tests' do

    let(:station) { create(:station) }
    let(:bike) { create(:bike, station: station) }
    let(:bike_maintenance) { create(:bike_maintenance, bike_id: bike.id) }

    it "is valid with valid attributes" do
      expect(bike_maintenance).to be_valid
    end

    it "is not valid without a bike" do
      bike_maintenance.bike_id = nil

      expect(bike_maintenance).to_not be_valid
    end

    it "is not valid without started_at" do
      bike_maintenance.started_at = nil

      expect { bike_maintenance.save }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it "is not valid without a reason" do
      bike_maintenance.reason = nil

      expect(bike_maintenance).to_not be_valid
    end
  end
end
