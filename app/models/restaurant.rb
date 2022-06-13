class Restaurant < ApplicationRecord
  belongs_to :manager, class_name: "User"
end
