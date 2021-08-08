class CoachResource < JSONAPI::Resource
  attributes :name

  has_many :courses
end
