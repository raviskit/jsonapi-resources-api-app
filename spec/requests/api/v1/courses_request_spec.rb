require "rails_helper"

RSpec.describe "Courses API", type: :request do
  let!(:coach) {create(:coach)}
  let!(:course_1) {create(:course, self_assignable: false, coach: coach)}
  let!(:course_2) {create(:course, coach: coach)}
  let!(:course_3) {create(:course, coach: coach)}

  describe "#index" do
    context "without filter" do
      it "returns all the courses" do
        get api_v1_courses_path
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed_response["data"].length).to be(3)
      end
    end

    context "With filter" do
      it "filters the result" do
        get '/api/v1/courses?filter[self_assignable]=false'
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed_response["data"].length).to be(1)
      end
    end
  end

  describe "#create" do
    before(:each) do
      @headers = { 'content-type': 'application/vnd.api+json' }
    end

    it "creates a course successfully" do
      @params =
        '{"data":{ "type":"courses", "attributes":{ "name":"course1"},
                  "relationships":{ "coach":{ "data": { "type":"coaches", "id": "'+ coach.id.to_s + '" }}}}}'
      expect { post api_v1_courses_path, params: @params, headers: @headers }.to change { Course.count }.by(1)
      expect(response).to have_http_status(:created)
    end

    it "Fails to create course when params are invalid" do
      @params =
        '{"data":{ "type":"courses", "attributes":{ "name":"course_1"},
                  "relationships":{ "coach":{ "data": { "type":"coaches", "id": "+coach.id.to_s+" }}}}}'

      post api_v1_courses_path, params: @params, headers: @headers
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "#show" do
    it "displays course based on id" do
      get api_v1_course_path(course_2.id)

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["data"]["attributes"]["name"]).to eq(course_2.name)
    end

    it "displays error when id not found" do
      get api_v1_course_path(Course.last.id + 1)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "#delete" do
    it "deletes course based on id" do
      expect{ delete api_v1_course_path(course_2.id) }.to change{ Course.count }.by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "fails to delete a course" do
      delete api_v1_course_path(Course.last.id + 1)

      expect(response).to have_http_status(:not_found)
    end
  end
end