class Activity < ApplicationRecord
  belongs_to :course

  validates :name, presence: true, length: { minimum: 2 }
end
