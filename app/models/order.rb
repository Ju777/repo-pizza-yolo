class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  private

  def order_recap 
    unless self.pickup_code == "not_paid"
      UserMailer.customer_order_email(self).deliver_now 
      UserMailer.pizzeria_order_email(self).deliver_now
    end
  end
end
