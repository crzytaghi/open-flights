module Api
  module V1
    class ReviewsController < ApplicationController
      def index
        airlines = Airline.all

        AirlineSerializer.new(airlines, options).serialized_json
      end

      def show
        airline = Airline.find_by(slug: params[:slug])

        AirlineSerializer.new(airline, options).serialized_json
      end

      def create
        airline = Airline.new(airline_params)

        if airline.save
          render json: AirlineSerializer.new(airline).serialized_json
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      def update
        airline = Airline.new(airline_params)

        if airline.update(airline_params)
          render json: AirlineSerializer.new(airline, options).serialized_json
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      def destroy
        airline = Airline.new(airline_params)

        if airline.destroy
          head :no_content
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      private

      def airline_params
        params.require(:airline).permit(:name, :image_url)
      end

      # Want to ensure that we are included any review data in the json payload by structuring the data as a compount document. 
      def options
        @options ||= { include: %i[reviews]}
      end
    end
  end
end