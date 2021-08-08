class Coach < ApplicationRecord
  has_many :courses

  after_destroy :update_courses

  private

  def update_courses
    courses.update(coach_id: Coach.last.id)
  end
end
