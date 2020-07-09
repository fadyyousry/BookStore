class Book < ApplicationRecord
  belongs_to :publisher, optional: true
  has_and_belongs_to_many :authors, -> { distinct }
  has_and_belongs_to_many :categories, -> { distinct }

  validates :title, presence: true
  validates :price, presence: true
  validates :image_link, presence: true
  validate :check_length

  def check_length
    unless isbn.size == 10 or isbn.size == 13
      errors.add(:isbn, "length must be 10 or 13") 
    end
  end

end
