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
    puts "#"*100

    product_to_add = Product.find(params[:product_id])
    @new_cart_product = CartProduct.new(cart:current_user.cart, product: product_to_add)
    @new_cart_product.quantity = 1

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
    #on identifie le produit selectionné dans le panier:
    @cartproduct_to_update = CartProduct.find(params[:id])

    puts " "
    puts "="*50
    puts "voici le cartproduct_to_update : #{@cartproduct_to_update}"
    puts "="*50
    puts " " 

    puts " "
    puts "="*50
    puts "qté du cartproduct_to_update : #{@cartproduct_to_update.quantity}"
    puts "="*50
    puts " "

    @cartproduct_to_update.quantity += 1 

    puts " "
    puts "="*50
    puts "qté du cartproduct_to_update apres l'update : #{@cartproduct_to_update.quantity}"
    puts "="*50
    puts " "
    
    # on redirige vers le panier (1ère étape, ensuite il faudra que ça soit fait via AJAX)
    redirect_to cart_path(current_user)
  end

  def destroy
    puts "#"*100
    puts "On est dans CartProduct#create"
    puts "params.inspect = #{params.inspect}"
    puts "#"*100

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
