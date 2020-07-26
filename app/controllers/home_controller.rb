class HomeController < ApplicationController
  def index
    @new_books = Book.newest 10
    @recommends = Book.best_seller 10
  end
end