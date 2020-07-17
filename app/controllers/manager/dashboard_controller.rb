module Manager
  class DashboardController < ApplicationController
    layout 'admin'

    def index
      authorize! :create, Book
    end
  end
end