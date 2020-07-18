module MenuDataPreload
    extend ActiveSupport::Concern
    included do
        before_action :authors_index, :categories_index
    end

    def authors_index
        @authors = Author.all
    end

    def categories_index
        @categories = Category.all
    end
end