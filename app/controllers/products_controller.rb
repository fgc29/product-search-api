class ProductsController < ApplicationController
  def search
    @product = Product.search(product_params[:product])

    if @product
      render json: @product, serializer: ProductSerializer
    else
      render json: {}
    end
  end

  private

  def product_params
    params.permit(:product)
  end
end