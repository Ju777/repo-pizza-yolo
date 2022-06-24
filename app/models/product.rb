class Product < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products
  belongs_to :category
  has_many :product_restaurants, dependent: :destroy
  has_many :restaurants, through: :product_restaurants
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title,
    presence: true,

    length: { in: 3..50 }
    

  validates :catchphrase,
    presence: true,
    length: { in: 3..200 }

  validates :description,
    presence: true,
    length: { in: 10..500 }

  validates :price,
    presence: true,
    numericality: { greater_than:0 }

  validates :image_url,
    presence: true
end
