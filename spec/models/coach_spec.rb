require 'rails_helper'

RSpec.describe Coach, type: :model do

  describe"#valid?" do
    let(:coach) { create(:coach) }

    it "is valid" do
      expect(coach.valid?).to be_truthy
    end

    context "invalid" do
      it "is invalid if name is less than 2 characters" do
        coach = Coach.new(name: "a")
        expect(coach.valid?).to be_falsy
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:courses) }
  end
end
