module Manager
  class ReviewsController < ApplicationController
    load_and_authorize_resource
    layout 'admin'

    def index
      @reviews = Review.all
    end
  end
end