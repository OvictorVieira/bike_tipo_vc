require 'rails_helper'

  RSpec.describe Bike, type: :model do
    context 'validations tests' do
      let(:bike) { create(:bike, code: '9988776655443') }

      it "is valid with valid attributes" do
        expect(bike).to be_valid
      end

      it "is not valid without a code" do
        bike.code = nil

        expect(bike).to_not be_valid
      end
    end
  end