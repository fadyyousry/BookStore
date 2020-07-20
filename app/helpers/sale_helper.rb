module SaleHelper
    def total_price
        price = 0
        @sales.each do |sale|
            price += sale.book.price
        end
        price
    end
end