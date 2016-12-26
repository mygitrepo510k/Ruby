require "spec_helper"

describe VoiceoversController do
  describe "routing" do

    it "routes to #index" do
      get("/voiceovers").should route_to("voiceovers#index")
    end

    it "routes to #new" do
      get("/voiceovers/new").should route_to("voiceovers#new")
    end

    it "routes to #show" do
      get("/voiceovers/1").should route_to("voiceovers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/voiceovers/1/edit").should route_to("voiceovers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/voiceovers").should route_to("voiceovers#create")
    end

    it "routes to #update" do
      put("/voiceovers/1").should route_to("voiceovers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/voiceovers/1").should route_to("voiceovers#destroy", :id => "1")
    end

  end
end
