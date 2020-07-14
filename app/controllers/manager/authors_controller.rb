module Manager
  class AuthorsController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    def index
      @authors = Author.all
    end

    def destroy
      @author.destroy 
      redirect_to authors_url, notice: t('author.messages.successful_destroy')
    end
  end
end