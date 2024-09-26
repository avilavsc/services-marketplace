class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service

  def new
    @review = @service.reviews.build
  end

  def create
    @review = @service.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @service, notice: "Avaliação enviada com sucesso."
    else
      render :new
    end
  end

  private

  def set_service
    @service = Service.find(params[:service_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
