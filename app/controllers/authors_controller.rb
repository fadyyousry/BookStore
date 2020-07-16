class AuthorsController < ApplicationController
  layout 'application'
  load_and_authorize_resource

  def index
    @authors = Author.all
    respond_to do |format|
      format.js
    end
  end
end