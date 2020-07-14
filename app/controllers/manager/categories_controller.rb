module Manager
  class CategoriesController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    def index
      @categories = Category.all
    end

    def destroy
      @category.destroy 
      redirect_to manager_categories_url, notice: t('category.messages.successful_destroy')
    end
  end
end