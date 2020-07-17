module Manager
  class DashboardController < ApplicationController
    layout 'admin'

    add_breadcrumb I18n.t('default.dashboard'), :manager_root_path

    def index
      authorize! :create, Book
    end
  end
end