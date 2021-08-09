require 'rails_helper'

RSpec.describe "Coaches API", type: :request do
  let!(:coach) { create(:coach) }

  describe "#index" do
    it "displays all the coaches" do
      get api_v1_coaches_path

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"].length).to be(1)
    end
  end

  describe "#create" do
    before(:each) do
      @headers = { 'content-type': 'application/vnd.api+json' }
    end

    it "creates a coach successfully" do
      params = '{"data":{ "type":"coaches", "attributes":{ "name":"Coach_1"}}}'
      expect{post api_v1_coaches_path, params: params, headers: @headers}.to change{ Coach.count }.by(1)
      expect(response).to have_http_status(:created)
    end

    it "fails to create a coach if name is not present" do
      params = '{"data":{ "type":"coaches", "attributes":{ "name":""}}}'

      expect{post api_v1_coaches_path, params: params, headers: @headers}.to change{ Coach.count }.by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end

  describe "#show" do
    it "displays the coach" do
      get api_v1_coach_path(coach.id)

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']['attributes']['name']).to eq(coach.name)
    end

    it "displays error when coach id not found" do
      get api_v1_coach_path(Coach.last.id + 1)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "#destroy" do
    let!(:coach_2) { create(:coach) }
    let!(:course) { create(:course, coach: coach_2) }


    it "deletes the course and assign the next available coach" do
      expect{ delete api_v1_coach_path(coach_2.id) }.to change{ Coach.count }.by(-1)
      expect(course.reload.coach_id).to eq(coach.id)
      expect(response).to have_http_status(:ok)
    end


    it "fails to delete coach when it has courses and not other coach is available" do
      coach.destroy
      expect{ delete api_v1_coach_path(coach_2.id)}.to raise_error StandardError
    end
  end
end