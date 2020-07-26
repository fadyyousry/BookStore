class Book < ApplicationRecord
  paginates_per 20

  belongs_to :publisher, optional: true
  has_one_attached :pdf_file
  has_many :reviews, dependent: :destroy
  has_many :sales
  has_many :users, through: :sales
  has_and_belongs_to_many :authors, -> { distinct }
  has_and_belongs_to_many :categories, -> { distinct }
  
  after_create :create_product
  after_update :update_product
  before_destroy :cascade

  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :image_link, presence: true ,:format => URI::regexp(%w(http https))
  validates :isbn, uniqueness:  true
  validate :check_isbn_length
  validate :correct_document_mime_type
  validate :valid_date?
  validates_numericality_of :isbn
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :page_count, greater_than: 0

  def correct_document_mime_type
    if pdf_file.attached? && !pdf_file.content_type.in?(%w(application/pdf))
      pdf_file.purge
      errors.add(:pdf_file, 'Must be a PDF or a DOC file')
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

  private
    def valid_date?
      if published_date.present? and published_date > Time.now 
        errors.add(:published_date, "can't be in the future!")
      end
    end

    def check_isbn_length
      unless isbn.size == 10 or isbn.size == 13
        errors.add(:isbn, "length must be 10 or 13")
      end
    end

    def cascade
      cascade_authors
      cascade_categories
    end

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
      CreateProductJob.perform_later self
    end

    def update_product
      UpdateProductJob.perform_later self
    end

    def human_name name
      name.split.map(&:capitalize).join(' ')
    end
end
