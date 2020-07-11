class Book < ApplicationRecord
  belongs_to :publisher, optional: true
  has_and_belongs_to_many :authors, -> { distinct }
  has_and_belongs_to_many :categories, -> { distinct }

  validates :title, presence: true
  validates :price, presence: true
  validates :isbn, uniqueness:  true
  validates :image_link, presence: true ,:format => URI::regexp(%w(http https))

  validate :check_length

  def check_length
    unless isbn.size == 10 or isbn.size == 13
      errors.add(:isbn, "length must be 10 or 13")
    end
  end

  def publisher_name
    publisher.name if publisher
  end

  def create_publisher publisher_hash
    publisher = Publisher.find_or_initialize_by(publisher_hash)
    if publisher.save
      self.publisher = publisher
    end
  end

  def create_authors authors_list
    authors_list.each do |values|
      author = Author.find_or_initialize_by(values)
      if author.save
        self.authors.append(author)
      end
    end
  end

  def create_categories categories_list
    categories_list.each do |values|
      category = Category.find_or_initialize_by(values)
      if category.save
        self.categories.append(category)
      end
    end
  end

end
