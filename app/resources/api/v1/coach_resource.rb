module Api
  module V1
    class CoachResource < JSONAPI::Resource
      attributes :name

      has_many :courses
    end
  end
end


