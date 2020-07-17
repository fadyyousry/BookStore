module Manager
  class BooksController < ActionController::Base
    layout 'admin'
    load_and_authorize_resource

    add_breadcrumb I18n.t('default.dashboard'), :manager_root_path
    add_breadcrumb I18n.t('activerecord.models.book.other'), :manager_books_path

    def index
      @books = Book.all
    end
  
    def create
      @book = Book.new(book_params)
      @book.create_publisher(publisher_params)
      @book.create_authors(author_params)
      @book.create_categories(category_params)
      if @book.save
        redirect_to manager_book_path(@book.id), notice: t('book.messages.successful_create')
      else
        render :new
      end
      
    end
  
    def update      
      @book.create_publisher(publisher_params)
      @book.create_authors(author_params)
      @book.create_categories(category_params)
      if @book.update(book_params)
        redirect_to manager_book_path(@book.id), notice: t('book.messages.successful_update')
      else
        render :edit
      end

    end
  
    def destroy
      @book.destroy
      redirect_to manager_books_url, notice: t('book.messages.successful_destroy') 
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
end