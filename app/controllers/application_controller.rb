class ApplicationController < ActionController::Base
  include DashboardRedirect
  include ErrorHandler
  include SearchMenus
  include SearchInitializer
end
