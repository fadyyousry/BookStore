class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    if current_user.reviews.create(review_params)
      redirect_back(fallback_location: book_path(params[:review][:book_id]),
                    notice: t("messages.success.create", model: Review.name))
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :book_id)
  end
end