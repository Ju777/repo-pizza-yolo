class ProductsController < ApplicationController
  def index
    @all_products = Product.all
  end

  def show
    @product_to_show = Product.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
