class Manager::OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_manager!
    def index
        @orders = Order.all
    end

    private 

    def check_if_manager!
        unless current_user.role == "manager"
            flash.notice = "Accès non autorisé."
            redirect_to root_path
        end 
    end
end
