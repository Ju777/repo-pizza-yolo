require "administrate/base_dashboard"

class ProductDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    cart_products: Field::HasMany,
    carts: Field::HasMany,
    category: Field::BelongsTo,
    product_restaurants: Field::HasMany,
    restaurants: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    price: Field::String.with_options(searchable: false),
    image_url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    catchphrase: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :cart_products,
    :carts,
    :category,
    :product_restaurants,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :cart_products,
    :carts,
    :category,
    :product_restaurants,
    :restaurants,
    :id,
    :title,
    :description,
    :price,
    :image_url,
    :created_at,
    :updated_at,
    :catchphrase,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :cart_products,
    :carts,
    :category,
    :product_restaurants,
    :restaurants,
    :title,
    :description,
    :price,
    :image_url,
    :catchphrase,
  ].freeze

  # Overwrite this method to customize how products are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(product)
  #   "Product ##{product.id}"
  # end
end
