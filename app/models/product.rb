class Product < ApplicationRecord
  has_many :cart_products
  has_many :carts, through: :cart_products
  belongs_to :category
  has_many :product_restaurants
  has_many :restaurants, through: :product_restaurants

  validates :title,
    presence: true,
    length: { in: 3..20 }

  validates :catchphrase,
    presence: true,
    length: { in: 3..100 }

  validates :description,
    presence: true,
    length: { in: 10..500 }

  validates :price,
    presence: true,
    numericality: { greater_than:0 }

  validates :image_url,
    presence: true
end
