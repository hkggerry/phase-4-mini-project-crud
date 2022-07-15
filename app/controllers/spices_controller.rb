class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        spices = Spice.all
        render json: spices
    end 

    def show
        spice = spice_find
        render json: spice
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = spice_find
            spice.update(spice_params)
            render json: spice
    end

    def destroy
        spice = spice_find
            spice.destroy
            head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def spice_find
        Spice.find_by(id: params[:id])
    end 

    def render_not_found_response
        render json: {error: "production not found"}, status: :not_found
    end
end
