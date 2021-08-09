require 'rails_helper'

RSpec.describe Course, type: :model do

  describe"#valid?" do
    let(:coach) { create(:coach) }
    let(:course) { create(:course, coach: coach) }

    it "is valid" do
      expect(course.valid?).to be_truthy
    end

    context "invalid" do
      it "is invalid if name is less than 2 characters" do
        course = Course.new(name: "a")
        expect(course.valid?).to be_falsy
      end

      it "is invalid if coach id is not present" do
        course = Course.new(name: "abc")
        expect(course.valid?).to be_falsy
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:activities) }
    it { is_expected.to belong_to(:coach) }
  end
end
