class BooksController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.create_publisher(publisher_params)
    @book.create_authors(author_params)
    @book.create_categories(category_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: t(:successful_create, scope: [:book, :messages]) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @book.create_publisher(publisher_params)
    @book.authors.clear
    @book.create_authors(author_params)
    @book.categories.clear
    @book.create_categories(category_params)

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: t(:successful_update, scope: [:book, :messages]) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: t(:successful_destroy, scope: [:book, :messages]) }
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :publisher_id, :published_date,
         :description, :isbn, :page_count, :image_link, :language, :is_pdf,
         :quantity, :price)
    end

    def publisher_params
      params.require(:publisher).permit(:name)
    end

    def author_params
      params.require(:authors).permit(:names)
    end

    def category_params
      params.require(:categories).permit(:names)
    end
end
