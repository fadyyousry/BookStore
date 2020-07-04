require 'will_paginate/array'

class GoogleBooksController < ApplicationController
  def index
    @books = GoogleBooks.for(params[:s]).paginate(page: params[:page], :per_page => 10)
  end

  def add
    book = Book.new(title: params[:book]["volumeInfo"]["title"],
      image_link: params[:book]["volumeInfo"]["imageLinks"]["smallThumbnail"],
      description: params[:book]["volumeInfo"]["description"])
  end

end
