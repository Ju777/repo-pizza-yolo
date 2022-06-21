class ProductsController < ApplicationController
  def index
    @all_products = Product.all
  end

  def show
    @products = Product.all

    @product_to_show = Product.find(params[:id]) 
  end

  def landing
    @all_products = Product.all
    @productssample = @all_products.sample(3)
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
