class CategoriesController < ApplicationController
  layout 'application'
  load_and_authorize_resource

  def show
    @books = @category.books.order(:title).page(params[:page])
  end
end