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
    allow_blank: true,
    length: { is: 10, message: "doit être composé de 10 chiffres" },
    format: {with: /\A[0]{1}[1-7]{1}[0-9]{8}\z/, message: "doit être composé de 10 chiffres et commencer par 01 ou 02 etc ..." },
  on: :create
end
