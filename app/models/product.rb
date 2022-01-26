class Product < ApplicationRecord

  validates :name, :price, :description, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { in: 6..300 }
  # validates :image, allow_blank: true, format: { with: %r{.(gif|jpg|png)\Z}i, message: 'must be a URL for GIF, JPG or PNG image.' }

  # def supplier
  #   Supplier.find(supplier_id)
  # end

  belongs_to :supplier
  has_many :images
  has_many :orders


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
