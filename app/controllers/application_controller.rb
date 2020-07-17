class ApplicationController < ActionController::Base
  include DashboardRedirect
  include ErrorHandler
  include SearchMenus
end
