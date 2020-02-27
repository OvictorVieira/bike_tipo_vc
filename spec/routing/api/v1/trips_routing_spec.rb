require "rails_helper"

RSpec.describe Api::V1::TripsController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/v1/trips").to route_to("api/v1/trips#index")
    end

    it "routes to #show" do
      expect(:get => "/api/v1/trips/1").to route_to("api/v1/trips#show", id: "1")
    end
  end
end
