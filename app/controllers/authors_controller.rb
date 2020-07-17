class AuthorsController < ApplicationController
  layout 'application'
  load_and_authorize_resource

  def show
    @books = @author.books.order(:title).page(params[:page])
  end
end