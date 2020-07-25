class HomeController < ApplicationController
  def index
    @new_books = Book.last(10).reverse
    @recommends = Book.left_joins(:sales).group(:id).order('COUNT(sales.id) DESC').limit(10)
  end
end