class Coach < ApplicationRecord
  has_many :courses

  validates :name, presence: true, length: { minimum: 2 }
end
