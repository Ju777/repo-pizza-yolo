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
      new_cart_product = CartProduct.new(product: product, cart:current_user.cart, quantity:1)

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

  def add_qty
    current_item = CartProduct.find(params[:id])
    current_item.update(quantity:current_item.quantity + 1)

    if current_item.save
      redirect_to cart_path(current_user.cart), notice: 'Quantité modifiée (+1).'
    else
      redirect_to cart_path(current_user.cart), notice: "Erreur: la quantité n'a pas été modifiée."
    end
  end

  def qty_minus_one
    current_item = CartProduct.find(params[:id])

    if current_item.quantity > 1
      current_item.update(quantity:current_item.quantity - 1)
    elsif current_item.quantity = 1
      current_item.destroy
    end

    if current_item.save
      redirect_to cart_path(current_user.cart), notice: 'Quantité modifiée (-1).'
    else
      redirect_to cart_path(current_user.cart), notice: "Erreur: la quantité n'a pas été modifiée."
    end
  end

end
