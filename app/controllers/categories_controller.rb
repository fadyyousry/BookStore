class CategoriesController < ApplicationController
  layout 'application'
  load_and_authorize_resource

  def index
    @categories = Category.all
    respond_to do |format|
      format.js
    end
  end
end