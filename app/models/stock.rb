class Stock < ApplicationRecord
  belongs_to :admin_product, class_name: "Admin::Product"

  validates :size, presence: true, uniqueness: { scope: :admin_product_id }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where('amount > 0') }
  scope :out_of_stock, -> { where(amount: 0) }
  scope :by_size, -> { order(:size) }

  def available?
    amount > 0
  end

  def out_of_stock?
    amount == 0
  end

end
