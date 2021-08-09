require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe"#valid?" do
    let(:coach) { create(:coach) }
    let(:course) { create(:course, coach: coach) }
    let(:activity) { create(:activity, course: course) }

    it "is valid" do
      expect(activity.valid?).to be_truthy
    end

    context "invalid" do
      it "is invalid if name is less than 2 characters" do
        activity = Activity.new(name: "a")
        expect(activity.valid?).to be_falsy
      end

      it "is invalid if course id is not present" do
        activity = Activity.new(name: "abc")
        expect(activity.valid?).to be_falsy
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:course) }
  end
end
