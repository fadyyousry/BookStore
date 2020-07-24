class SalesController < ApplicationController
    layout 'application'
    load_and_authorize_resource

    def index
      if params[:cart]
        @sales = @sales.in_progress.page(params[:page])
        render 'cart'
      else
        @sales = @sales.completed.page(params[:page])
        render 'history'
      end
    end
    
    def create
      @sale = current_user.sales.new(sale_params)
      if @sale.save
          if @sale.book.price == 0
            @sale.update({status: :completed, payment_time: Time.now})
            flash[:notice] = t('default.messages.added_to_profile')
          else
            flash[:notice] = t("default.messages.added_to_cart")
          end
          redirect_to book_path(book_id)
      else
          redirect_to book_path(book_id), alert: t("default.error_messages.cannot_add_to_cart")
      end
    end

    def destroy
      @sale.destroy
      redirect_to sales_url(cart: true), notice: t("default.messages.removed_from_cart")
    end

    private
      def sale_params
        params.permit(:book_id)
      end

      def book_id
        sale_params[:book_id]
      end
end