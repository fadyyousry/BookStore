class ApplicationController < ActionController::Base
  include DashboardRedirect
  include ErrorHandler
  include SearchInitializer
end
