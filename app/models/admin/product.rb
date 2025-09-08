class Admin::Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end

  belongs_to :category, class_name: "Admin::Category", foreign_key: "category_id", optional: true
  has_many :stocks, dependent: :destroy, foreign_key: "admin_product_id"

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :active, -> { where(active: true) }

  def available_sizes
    # stocks.available.by_size.map(&:size)
    stocks.available.pluck(:size).sort
  end

  def total_stock
    stocks.sum(:amount)
  end

  def stock_for_size(size)
    stocks.find_by(size: size)&.amount || 0
  end

  def available?
    total_stock > 0
  end
end
