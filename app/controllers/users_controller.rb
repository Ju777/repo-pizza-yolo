class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_user, only: [:show, :edit, :update, :destroy,]
  before_action :check_profile_owner, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    # (par Julien) Comme c'est directement le curren_user qui est appelé dans la view users#show, les variables suivantes ne servent qu'au controller.
    # On devrait pouvoir les supprimer, elles ne sont pas appelées ailleurs pour l'instant.

    
    # @firstname = current_user.firstname
    # @lastname = current_user.lastname
    # @email = current_user.email
    # @phone = current_user.phone
      @user = current_user
      @user_orders = current_user.orders
      
  end

  def edit

   @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: "Modifications enregistrées" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :description, :firstname, :lastname, :phone,)
  end


  
  def check_profile_owner
    profile_owner = User.find(params[:id])
        
    unless current_user == profile_owner
      flash.notice = "Accès non autorisé."
      redirect_to root_path
    end
  end

end
