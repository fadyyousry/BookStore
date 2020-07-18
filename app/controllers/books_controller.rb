class BooksController < ApplicationController
  layout 'application'
  load_and_authorize_resource

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.order(:title).page(params[:page])
  end

end
