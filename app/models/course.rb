class Course < ApplicationRecord
  has_many :activities
  belongs_to :coach

  validates :name, presence: true
end
