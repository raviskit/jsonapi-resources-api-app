module Api
  module V1
    class CourseResource < JSONAPI::Resource
      attributes :name, :self_assignable, :coach

      has_many :activities
      has_one :coach

      filter :self_assignable

      def coach
        @model.coach.to_json
      end
    end
  end
end


