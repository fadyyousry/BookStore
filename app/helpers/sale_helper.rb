module SaleHelper
    def total_price
        @sales.sum do |sale|
            sale.book.price
        end
    end

    def extract_products_params
        (@sales.map {|sale| sale.book}).as_json(only: [:product_id, :price])
    end
end