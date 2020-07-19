class ShoppingController < ApplicationController
    layout 'application'

    def show_cart
        @books = current_user.books.page(params[:page])
    end

    def add_to_cart
        item = InCart.new ()
        item.user_id = current_user.id
        item.book_id = book_id
        item.save
        if item.save
            redirect_to book_path(book_id), notice: t("default.messages.add_to_cart")
        else
            redirect_to book_path(book_id), alert: t("default.error_messages.cannot_add_to_cart")
        end
    end

    private
      def book_id
        params[:book_id]
      end
end