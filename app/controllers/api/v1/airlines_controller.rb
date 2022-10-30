module Api
  module V1
    class AirlinesController < ApplicationController
      before_action :set_airline, only: [:show, :update, :destroy]
      skip_before_action :verify_authenticity_token

      def index
        begin
          @airlines = Airline.all

          raise "airlines not found, errors: #{@airlines.errors}" unless @airlines
          # render json: AirlineSerializer.new(airlines, options).serializable_hash
          render json: AirlineBlueprint.render(@airlines, options)
        rescue => err
          render json: { success: false, error: err }
        end
      end

      def show
        begin
          raise "airline not found, errors: #{@airline.errors.messages}" unless @airline
          render json: AirlineBlueprint.render(@airline)
        rescue => err
          render json: { success: false, error: err }
        end
      end

      def create
        begin
          @airline = Airline.create(airline_params)

          raise "airline not found, errors: #{@airline.errors.messages}" unless @airline.valid?
          render json: AirlineBlueprint.render(@airline)
        rescue => err
          render json: { success: false, error: err }
        end
      end

      def update
        begin
          @airline.update(airline_params)
          raise "unable to update airline, errors: #{@airline.errors.messages}" unless @airline.valid?
          render json: AirlineBlueprint.render(@airline, options)
        rescue => err
          render json: { success: false, error: err }
        end
      end

      def destroy
        begin
          @airline.destroy

          raise "unable to delete airline, errors: #{@airline.errors.messages}" unless @airline.valid?
          render json: AirlineBlueprint.render(@airline, options)
        rescue => err
          render json: { success: false, error: err }
        end
      end

      private

      def set_airline
        @airline = Airline.find(params[:id])
      end

      def airline_params
        params.require(:airline).permit(
          :id, 
          :name, 
          :image_url
        )
      end

      # Want to ensure that we are including any review data in the json payload by structuring the data as a compound document. 
      def options
        # Allows us to pass in an optional options hash that will be returned when passed into the render method
        # instance variable @options
        @options ||= { include: %i[reviews]}
      end
    end
  end
end