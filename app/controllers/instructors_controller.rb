class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
def index
        @instructors = Instructor.all
        render json: @instructors
    end

    def show
        @instructor = Instructor.find(params[:id])
        render json: @instructor
    end

    def create
        @instructor = Instructor.create!(instructor_params)
        render json: @instructor
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy!
        head :no_content
    end


    private

    def render_not_found_response
        render json: { errors: "Record not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: errors.full_messages }, status: :unprocessable_entity
    end

    def instructor_params
        params.permit(:name)
    end
end
