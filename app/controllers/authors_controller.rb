class AuthorsController < ApplicationController
  load_and_authorize_resource

    def index
      @authors = Author.all
    end

    def show
      @books = @author.books
    end

    def destroy
      @author.destroy
      respond_to do |format|
        format.html { redirect_to authors_url, notice: t(:successful_destroy, scope: [:author, :messages]) }
      end
    end
end