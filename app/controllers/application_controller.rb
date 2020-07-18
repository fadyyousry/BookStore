class ApplicationController < ActionController::Base
  include DashboardRedirect
  include ErrorHandler
  include MenuDataPreload
  include SearchInitializer
end
