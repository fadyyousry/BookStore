module Manager
  class AuthorsController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    def index
      @authors = Author.all
    end

    def destroy
      @author.destroy 
      redirect_to manager_authors_url, notice:  t("messages.success.destroy", model: @author.class.name)
    end
  end
end