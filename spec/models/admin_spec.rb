require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'validations tests' do
    let(:admin) { create(:admin) }

    it "is valid with valid attributes" do
      expect(admin).to be_valid
    end
  end
end
