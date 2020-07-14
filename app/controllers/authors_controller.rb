class AuthorsController < ApplicationController
  load_and_authorize_resource
  layout 'application'
  def index
    @authors = Author.all
  end

  def show
    @books = @author.books
  end
end