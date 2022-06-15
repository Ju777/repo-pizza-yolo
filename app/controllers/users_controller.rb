class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :check_profile_owner, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    # (par Julien) Comme c'est directement le curren_user qui est appelé dans la view users#show, les variables suivantes ne servent qu'au controller.
    # On devrait pouvoir les supprimer, elles ne sont pas appelées ailleurs pour l'instant.

    # @user = current_user
    # @firstname = current_user.firstname
    # @lastname = current_user.lastname
    # @email = current_user.email
    # @phone = current_user.phone

      @user_orders = current_user.orders
      
  end
  
  private

  def check_profile_owner
    profile_owner = User.find(params[:id])
        
    unless current_user == profile_owner
      flash.notice = "Accès non autorisé."
      redirect_to root_path
    end
  end

end
