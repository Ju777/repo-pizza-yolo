class Order < ApplicationRecord
  after_create :order_recap
  
  belongs_to :user
  belongs_to :restaurant

  def order_recap
    UserMailer.order_recap_email(self).deliver_now
  end
end
