class Order < ApplicationRecord
  after_update :order_recap
  
  belongs_to :user, dependent: :destroy
  belongs_to :restaurant

  private
  
  #method to send emails after an order is paid
  def order_recap 
    unless self.pickup_code == "not_paid"
      UserMailer.customer_order_email(self).deliver_now # email sent to customer
      UserMailer.pizzeria_order_email(self).deliver_now # email sent to restaurant's manager
    end
  end

end
