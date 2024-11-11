class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to @review.product
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :user_id, :rating, :comment, :review_date)
  end
end
