class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.create_publisher(publisher_params)
    @book.create_authors(authors_list)
    @book.create_categories(categories_list)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @book.create_publisher(publisher_params)
    @book.authors.clear
    @book.create_authors(authors_list)
    @book.categories.clear
    @book.create_categories(categories_list)

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :publisher_id, :published_date,
         :description, :isbn, :page_count, :image_link, :language, :is_pdf,
         :quantity, :price)
    end

    def publisher_params
      params.require(:publisher).permit(:name)
    end

    def author_params
      params.permit(authors:[:name])
    end

    def category_params
      params.permit(categories:[:name])
    end

    def authors_list
      author_params[:authors] || []
    end

    def categories_list
      category_params[:categories] || []
    end
end
