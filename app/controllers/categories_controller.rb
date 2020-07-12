class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def show
    @books = @category.books
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: t(:successful_destroy, scope: [:category, :messages]) }
    end
  end
end