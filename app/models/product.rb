class Product < ApplicationRecord
  belongs_to :Cart
  has_many :cartItems
end