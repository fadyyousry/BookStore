class Book < ApplicationRecord
  paginates_per 12

  belongs_to :publisher, optional: true
  has_many :reviews, dependent: :destroy
  has_many :sales
  has_many :users, through: :sales
  has_and_belongs_to_many :authors, -> { distinct }
  has_and_belongs_to_many :categories, -> { distinct }
  
  before_create :create_product
  before_destroy :cascade

  validates :title, presence: true
  validates :description, presence: true
  validates :image_link, presence: true ,:format => URI::regexp(%w(http https))
  validates :isbn, uniqueness:  true
  validates_numericality_of :isbn
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :page_count, greater_than: 0
  validate :check_length
  validate :valid_date?

  def valid_date?
    if published_date.present? and published_date > Time.now 
      errors.add(:published_date, "can't be in the future!")
    end
  end

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
      author = Author.find_or_initialize_by({name: human_name(value)})
      if author.save
        self.authors.append(author)
      end
    end
  end

  def create_categories categories_params
    cascade_categories
    self.categories.clear
    categories_params[:names].split(',').each do |value|
      category = Category.find_or_initialize_by({name: human_name(value)})
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

    def create_product
      begin
        product = Stripe::Product.create({
                    name: title,
                    images: [image_link],
                    description: description
                  })
        self.product_id = product.id
      rescue => e
        Rails.logger.debug e.message
      end
    end

    def human_name name
      name.split.map(&:capitalize).join(' ')
    end
end
