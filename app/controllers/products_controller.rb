class ProductsController < ApplicationController
  def index
    @all_products = Product.all
    @all_pizzas = @all_products.where(category: Category.first)
    @all_desserts = @all_products.where(category: Category.second)
    @all_drinks = @all_products.where(category: Category.third)
    @cat_pizza = Category.first
    @cat_dessert = Category.second
    @cat_drink = Category.third
    @category_id = params[:category]
  end

  def show
    @products = Product.all
    @product_to_show = Product.friendly.find(params[:id])
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
