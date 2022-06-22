class CartProductsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
  end

  def create
    product = Product.find(params[:product_id])

    existing_cart_product = CartProduct.find_by(product: product, cart: current_user.cart)

    unless current_user.cart.products.include?(product)
      fake_schedule = Schedule.create(date:Time.new(1900, 01, 01, 00, 00, 00))
      new_cart_product = CartProduct.new(product: product, cart:current_user.cart, quantity:1, schedule:fake_schedule)

      if new_cart_product.save
        flash[:success] = "Produit ajouté au panier"
        redirect_to cart_path(current_user.cart)
      else
        flash[:error] = "Erreur d'ajout au panier"
        redirect_to root_path
      end

    else
      existing_cart_product.update(quantity: existing_cart_product.quantity+1)
      redirect_to cart_path(current_user.cart)
    end
  end

  def edit
  end

  def update
    @cart_product = CartProduct.find(params[:id])

    if params[:increment] == "true"
      @cart_product.update!(quantity: @cart_product.quantity+1)
    elsif params[:decrement] == "true" && @cart_product.quantity >= 1
      @cart_product.update!(quantity: @cart_product.quantity-1)
      if @cart_product.quantity == 0
        @cart_product.destroy
      end
    else
      @cart_product.destroy
    end

    respond_to do |format|
      format.html { redirect_to cart_path(current_user.cart) }
      format.js {}
    end

  end

  def destroy
    product = CartProduct.find(params[:id])
    product.destroy

    respond_to do |format|
      format.html {
        flash.notice = "Produit retiré du panier"
        redirect_to cart_path(current_user.cart)
      }
      format.js {}
    end
  end

  #def add_qty
    #current_item = CartProduct.find(params[:id])
    #current_item.update(quantity:current_item.quantity + 1)

    #if current_item.save
      #redirect_to cart_path(current_user.cart), notice: 'Quantité modifiée (+1).'
    #else
      #redirect_to cart_path(current_user.cart), notice: "Erreur: la quantité n'a pas été modifiée."
    #end
  #end

  #def qty_minus_one
    #current_item = CartProduct.find(params[:id])

    #if current_item.quantity > 1
      #current_item.update(quantity:current_item.quantity - 1)
    #elsif current_item.quantity = 1
      #current_item.destroy
    #end

    #if current_item.save
      #redirect_to cart_path(current_user.cart), notice: 'Quantité modifiée (-1).'
    #else
      #redirect_to cart_path(current_user.cart), notice: "Erreur: la quantité n'a pas été modifiée."
    #end
  #end

end
