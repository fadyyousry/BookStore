module BookHelper
    def csv_names(list)
        list.pluck(:name).join(', ')
    end

    def human_price(price)
        price == 0 ? "Free": "$" + price.to_s
    end

    def buy_book_button_name
        @book.price == 0 ? t('default.own_it') : t('default.add_to_cart')
    end
end