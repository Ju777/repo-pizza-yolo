class UsersController < ApplicationController
    def index
    end
    def show
        @user = current_user
        @firstname = current_user.firstname
        @lastname = current_user.lastname
        @email = current_user.email
        @phone = current_user.phone

        @orders = current_user.orders.last
        
    end
    
end
