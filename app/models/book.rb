class Book < ApplicationRecord
  paginates_per 12
  belongs_to :publisher, optional: true
  has_and_belongs_to_many :authors, -> { distinct }
  has_and_belongs_to_many :categories, -> { distinct }
  before_destroy :cascade

  validates :title, presence: true
  validates :price, presence: true
  validates :isbn, uniqueness:  true
  validates :image_link, presence: true ,:format => URI::regexp(%w(http https))
  validate :check_length

  IMAGE_SIZE = "141x218"

  def check_length
    unless isbn.size == 10 or isbn.size == 13
      errors.add(:isbn, "length must be 10 or 13")
    end
  end

  def publisher_name
    publisher.name if publisher
  end

  def create_publisher publisher_params
    publisher = Publisher.find_or_initialize_by(publisher_params)
    if publisher.save
      self.publisher = publisher
    end
  end

  def create_authors authors_params
    cascade_authors
    self.authors.clear
    authors_params[:names].split(',').each do |value|
      author = Author.find_or_initialize_by({name: value})
      if author.save
        self.authors.append(author)
      end
    end
  end

  def create_categories categories_params
    cascade_categories
    self.categories.clear
    categories_params[:names].split(',').each do |value|
      category = Category.find_or_initialize_by({name: value})
      if category.save
        self.categories.append(category)
      end
    end
  end

  def cascade
    cascade_authors
    cascade_categories
  end

  private
    def cascade_authors
      authors.each do |author|
        if author.books.size == 1
          author.destroy
        end
      end
    end

    def cascade_categories
      categories.each do |category|
        if category.books.size == 1
          category.destroy
        end
      end
    end
end
