require "rails_helper"

RSpec.describe TripsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/trips").to route_to("trips#index")
    end

    it "routes to #show" do
      expect(:get => "/trips/1").to route_to("trips#show", id: "1")
    end
  end
end
