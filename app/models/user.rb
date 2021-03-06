class User < ApplicationRecord
  after_create :welcome_send
  after_create :create_cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :comments
  has_one :managed_restaurant, foreign_key: 'manager_id', class_name: "Restaurant"
  has_one_attached :avatar

  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :firstname, :lastname,
    length: { maximum: 30 },
    format: { with: /\A([A-Z]|[a-z]|\s|['éèàç-])*\z/, message: "contient un ou des caractères non valides." },
  on: :update

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def create_cart
    Cart.create(user:self)
  end

  def set_default_role
    self.role ||= :user
  end
end