class ApplicationController < ActionController::Base
  include DashboardRedirect
  include ErrorHandler
  include MenuDataPreload
  include SearchInitializer
  include MediaDataPreload
end
