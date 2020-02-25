require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations tests' do
    let(:user) { create(:user) }

    it "is valid without email" do
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user.name = nil

      expect(user).to_not be_valid
    end
  end
end