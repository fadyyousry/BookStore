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

    @publisher = Publisher.where(name: publisher_params[:name]).first ||
                  Publisher.new(publisher_params)
    @book.publisher = @publisher

    author_params.each do |values|
      author = Author.where(name: values[:name]).first || Author.new(values)
      if author.save
        @book.authors.append(author)
      end
    end

    category_params.each do |values|
      category = Category.where(name: values[:name]).first ||
                  Category.new(values)
      if category.save
        @book.categories.append(category)
      end
    end

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @publisher = Publisher.where(name: publisher_params[:name]).first ||
                  Publisher.new(publisher_params)
    @book.publisher = @publisher

    @book.authors.clear
    author_params.each do |values|
      author = Author.where(name: values[:name]).first || Author.new(values)
      if author.save
        @book.authors.append(author)
      end
    end

    @book.categories.clear
    category_params.each do |values|
      category = Category.where(name: values[:name]).first ||
              Category.new(values)
      if category.save
        @book.categories.append(category)
      end
    end

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
      params.permit(authors:[:name]).require(:authors)
    end

    def category_params
      params.permit(categories:[:name]).require(:categories)
    end
end
