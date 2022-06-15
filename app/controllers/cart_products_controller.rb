class CartProductsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
  end

  def create
    puts "#"*100
    puts "On est dans CartProduct#create"
    puts "params.inspect = #{params.inspect}"
    puts "params[:product] = #{params[:product]}"
    puts "#"*100

    product_to_add = Product.find(params[:product])
    @new_cart_product = CartProduct.new(cart:current_user.cart, product: product_to_add)

    if @new_cart_product.save
      flash.notice="Produit ajouté avec succès."
      redirect_to products_path
    else
      flash.alert="Produit non ajouté. Erreur."
      redirect_to product_path(product_to_add)
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
