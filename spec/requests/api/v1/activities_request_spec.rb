require "rails_helper"

RSpec.describe "Activities API", type: :request do
  let!(:activity_1) { create(:activity) }
  let!(:activity_2) { create(:activity) }
  let!(:course) { create(:course) }


  describe "#index" do
    it "displays all the activities" do
      get api_v1_activities_path

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(2)
    end
  end

  describe "#create" do

    before(:each) do
      @headers = { 'content-type': 'application/vnd.api+json' }
    end

    it "creates an activity" do
      params = '{"data":{ "type":"activities", "attributes":{ "name":"activity 1"},
                "relationships":{ "course":{ "data":{ "type":"courses", "id":"' + course.id.to_s + '"}}}}}'

      expect{ post api_v1_activities_path, params: params, headers: @headers}.to change {Activity.count}.by (1)
      expect(response).to have_http_status(:created)
    end

    it "fails to create an activity with invalid params" do
      params = '{"data":{"type":"activities", "attributes":{"name":"activity 1"}}}'
      expect{ post api_v1_activities_path, params: params, headers: @headers}.to change {Activity.count}.by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "#show" do
    it "shows the activity based on id" do
      get api_v1_activity_path(activity_1.id)

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]["attributes"]["name"]).to eq(activity_1.name)
    end

    it "displays error if id not found" do
      get api_v1_activity_path(Activity.last.id + 1)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "#delete" do
    it "deletes activity based on id" do
      expect{ delete api_v1_activity_path(activity_1.id) }.to change{ Activity.count }.by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "fails to delete an activity" do
      delete api_v1_activity_path(Activity.last.id + 1)

      expect(response).to have_http_status(:not_found)
    end
  end
end