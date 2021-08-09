require 'rails_helper'

RSpec.describe Api::V1::CoachesController, type: :controller do

  let!(:coach) { create(:coach) }
  let!(:another_coach) { create(:coach) }
  let!(:course) { create(:course, coach: coach) }

  context "#destroy" do
    it "updates courses with coach after it is deleted" do
      delete :destroy, params: { id: coach.id }

      expect(Coach.count).to be(1)
      expect(course.reload.coach.id).to eq(another_coach.id)
    end

    it "throws error when there is no coaches available" do
      delete :destroy, params: { id: coach.id }

      expect { delete :destroy, params: { id: another_coach.id } }.to raise_error StandardError
    end
  end

end