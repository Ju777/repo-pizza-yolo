class User < ApplicationRecord
  after_create :welcome_send
  after_create :create_cart

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_one :cart
  has_many :comments
  has_one :managed_restaurant, foreign_key: 'manager_id', class_name: "Restaurant"
  has_one_attached :avatar

  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :firstname, :lastname,
    length: { maximum: 30 }

  validates :phone,
    format: {with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/}



  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def create_cart
    # puts à supprimer en review finale
    puts "Creating cart"
    Cart.create(user:self)
  end

  def set_default_role
    self.role ||= :user
  end
end
