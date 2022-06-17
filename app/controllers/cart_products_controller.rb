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

    cart_product = CartProduct.find_by(product: product, cart: current_user.cart)

    unless current_user.cart.products.include?(product)
      @cart_product = CartProduct.new(product: product, cart:current_user.cart, quantity:1)
    else
      @cart_product.update(quantity: cart_product.quantity+1)
    end

    if @cart_product.save!
      flash[:success] = "Produit ajouté au panier"
      redirect_to cart_path(current_user.cart)
    else
      flash[:error] = "Erreur d'ajout au panier"
      redirect_to root_path
    end




=begin
    #on identifie le produit à ajouter au panier via la table intermedaire CartProducts:
    product_to_add = Product.find(params[:product_id])

    searched_cart_products = current_user.cart.cart_products.where(product: product_to_add)

    @new_cart_product = CartProduct.new(cart:current_user.cart, product: product_to_add)
    @new_cart_product.quantity = 1
    @new_cart_product.save

    if current_user.cart.cart_products.where(product: product_to_add).length > 0
      puts " "
      puts "#"*50
      puts "le cart product existe"
      puts "#"*50
      puts " "
    else
      puts " "
      puts "="*50
      puts "le cart product n'existe pas"
      puts "="*50
    end


    #Si ce produit n'est pas dans le panier, alors on l'y ajoute; sinon, ajouter +1 à la quantité du CartProduct en question :
    if current_user.cart.products.include?(product_to_add)
      product_to_add.update(quantity: searched_cart_products.quantity + 1) # <- il nous faut chercher la quantité non pas du product_to_add, mais du CartProduct déja existant... et je n'arrive pas à trouver comment faire pour identifier cette variable...
    else
      @new_cart_product = CartProduct.new(cart:current_user.cart, product: product_to_add)
      @new_cart_product.quantity = 1
    end

    if @new_cart_product.save
      flash.notice="Produit ajouté avec succès."
      redirect_to cart_path(current_user.cart)
    else
      flash.alert="Produit non ajouté. Erreur."
      redirect_to product_path(product_to_add)
    end

=end

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

end
