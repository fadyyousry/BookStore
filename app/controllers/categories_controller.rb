class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :destroy]

    def index
      @categories = Category.all
    end

    def show
      @books = @category.books
    end

    def destroy
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      end
    end

    private
    def set_category
      @category = Category.find(params[:id])
    end
end