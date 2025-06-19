class CommentsController < ApplicationController
  before_action :set_product, only: %i[create]

  def create
    @product.comments.create(comment_params)

    render json: {}, status: :no_content
  end

  private

  def set_product
    @product ||= Product.find(params[:product_id])
  end

  def comment_params
    params.require(:comment).permit(:description)
  end
end
