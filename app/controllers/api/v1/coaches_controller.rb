module Api
  module V1
    class CoachesController < ApplicationController

      def destroy
        @coach = Coach.find(params[:id])
        if @coach.destroy
          update_courses
          render json: {message: "Coach deleted successfully"}, status: 200
        else
          render json: {message: "Unable to delete Coach: #{@coach.name}"}, status: 500
        end
      end

      private

      def update_courses
        @coach.courses.update(coach_id: Coach.last.id)
      end
    end
  end
end

