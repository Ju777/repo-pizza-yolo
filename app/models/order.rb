class Order < ApplicationRecord
  after_create :order_recap #we can try 'after_update' for the email to be sent only after we update the order as being 'paid' ?
  
  belongs_to :user

  def order_recap
    UserMailer.order_recap_email(self).deliver_now
  end
end
