module Api
  module V1
    class ReviewsController < ApplicationController

      def create
        begin
          @review = Review.create(review_params)

          raise "reviews not found, errors: #{@reviews.errors.messages}" unless @reviews
          render json: ReviewBlueprint.render(@reviews)
        rescue => err
          render json: { success: false, error: err }
        end
      end

      def destroy
        begin
          @review.destroy

          raise "unable to delete review, errors: #{@review.errors.messages}" unless @review.valid?
          render json: ReviewBlueprint.render(@review)
        rescue => err
          render json: { success: false, error: err }
        end
      end

      private
      def set_review
        @review = Review.find(params[:id])
      end

      def review_params
        params.require(review).permit(
          :id,
          :title, 
          :description, 
          :score, 
          :airline_id
        )
      end
    end
  end
end