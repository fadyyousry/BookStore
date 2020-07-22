class SalesController < ApplicationController
    layout 'application'
    load_and_authorize_resource

    def index
      @sales = @sales.in_progress.page(params[:page])
    end
    
    def create
      @sale = current_user.sales.new(sale_params)
      if @sale.save
          redirect_to book_path(book_id), notice: t("default.messages.added_to_cart")
      else
          redirect_to book_path(book_id), alert: t("default.error_messages.cannot_add_to_cart")
      end
    end

    def destroy
      @sale.destroy
      redirect_to sales_url, notice: t("default.messages.removed_from_cart")
    end

    private
      def sale_params
        params.permit(:book_id)
      end

      def book_id
        sale_params[:book_id]
      end
end