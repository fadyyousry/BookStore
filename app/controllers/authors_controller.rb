class AuthorsController < ApplicationController
    before_action :set_author, only: [:show, :destroy]

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

    private
    def set_author
      @author = Author.find(params[:id])
    end
end