class Admin::Category < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50 ]
  end

  has_many :admin_products, class_name: "Admin::Product", dependent: :destroy
  # has_many :admin_products, foreign_key: "category_id", dependent: :destroy
end
