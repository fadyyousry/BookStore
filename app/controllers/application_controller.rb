class ApplicationController < ActionController::Base
  include DashboardRedirect
  include ErrorHandler
end
