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
        if @book.product_id.nil?
          flash[:alert] = t('messages.fail.connection_failed')
        else
          flash[:notice] =  t("messages.success.create", model: @book.class.name)
        end
        redirect_to manager_books_path
      else
        render :new
      end
      
    end
  
    def update      
      @book.create_publisher(publisher_params)
      @book.create_authors(author_params)
      @book.create_categories(category_params)
      if @book.update(book_params)
        redirect_to manager_books_path, notice: t("messages.success.update", model: @book.class.name)
      else
        render :edit
      end

    end
  
    def destroy
      begin
        @book.destroy
        redirect_to manager_books_url, notice: t("messages.success.destroy", model: @book.class.name)
      rescue ActiveRecord::InvalidForeignKey
        redirect_to manager_books_url, alert: t("messages.fail.destroy", model: @book.class.name)
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
end