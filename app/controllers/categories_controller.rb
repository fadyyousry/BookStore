class CategoriesController < ApplicationController
  layout 'application'
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def show
    @books = @category.books
  end
end