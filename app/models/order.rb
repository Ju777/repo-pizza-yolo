class Order < ApplicationRecord
  after_update :order_recap
  
  belongs_to :user

  def order_recap
    UserMailer.customer_order_email(self).deliver_now # email sent to customer
    UserMailer.pizzeria_order_email(self).deliver_now # email sent to restaurant's manager
  end
end
