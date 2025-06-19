class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]

  def index
    # low level caching

    Rails.cache.fetch("products", expires_in: 12.hours) do
      @pagy, @products = pagy(Product.all)
    end
  end

  def show
    ProductWelcomeJob.perform_later(product)

    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def edit
  end

  def update
    if product.update(product_params)
      redirect_to product
    else
      render :edit
    end
  end

  def destroy
    product.destroy

    redirect_to products_path
  end

  private

  def product
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name)
  end
end
