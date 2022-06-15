class Order < ApplicationRecord
  after_update :order_recap
  
  belongs_to :user

  private

  def order_recap
    unless self.pickup_code == "not_paid"
      UserMailer.order_recap_email(self).deliver_now
    end
  end

end
