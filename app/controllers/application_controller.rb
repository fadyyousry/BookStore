class ApplicationController < ActionController::Base
  include DashboardRedirect
  include ErrorHandler

  before_action :load_authors, only: [:index, :show], unless: :not_admin?
  before_action :load_categories, only: [:index, :show], unless: :not_admin?

  def load_authors
    @authors = Author.all
  end

  def load_categories
    @categories = Category.all
  end

  def not_admin?
    request.env['PATH_INFO'].include?('/manager/')
  end
end
