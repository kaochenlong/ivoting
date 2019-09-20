class Product < ApplicationRecord
  has_many :skus
  accepts_nested_attributes_for :skus, allow_destroy: true
end
