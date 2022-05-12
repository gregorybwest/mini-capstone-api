class Product < ApplicationRecord

  validates :name, :price, :description, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { in: 6..300 }
 
  belongs_to :supplier
  has_many :images
  has_many :carted_products 
  has_many :orders, through: :carted_products
  has_many :product_categories
  has_many :categories, through: :product_categories 


  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end

  def is_discounted?
    price < 10 
  end
      

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

end
