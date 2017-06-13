require 'rails_helper'

RSpec.describe BotController, type: :controller do
  describe "GET # webhook" do
    context "when params are missing or incorrect" do
      it "returns an error if no params are sent" do
        get :webhook
        expect(response.body).to eq("error")
      end

      it "returns an error if incorrect params are sent" do
        get :webhook, params: {wrong_params: "xyz"}
        expect(response.body).to eq("error")
      end
    end

    context "when sufficient params are sent" do
      it "returns an error if the verification token is incorrect" do
        get :webhook, params: {
          'hub.challenge' => "123456",
          'hub.verify_token' => "xyz"
        }
        expect(response.body).to eq("error")
      end

      it "echos the incomming challenge if the verification token is correct" do
        get :webhook, params: {
          'hub.challenge' => "123456",
          'hub.verify_token' => "mysecretverifytoken"
        }
        expect(response.body).to eq("123456")
      end
    end
  end

  describe "POST # receive_message" do

  end
end
