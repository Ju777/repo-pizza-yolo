class Restaurant < ApplicationRecord
  belongs_to :manager, class_name: "User"
  has_many :product_restaurants
  has_many :products, through: :product_restaurants
  has_many :orders

  validates :name, :street, :city,
    presence: true,
    length: { maximum: 100 }

  validates :zipcode,
    presence: true,
    format: { with: /\A(?:0[1-9]|[1-8]\d|9[0-8])\d{3}\z/ }
    
  validates :phone,
    presence: true,
    format: {with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/}
end
