class Comment < ApplicationRecord
  belongs_to :user

  validates :note,
    presence: true
    
  validates :description,
    presence: true,
    length: { in: 3..500 }
end
