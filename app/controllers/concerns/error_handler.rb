module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from CanCan::AccessDenied do |exception|
      Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to main_app.root_url, :alert => exception.message }
      end
    end
  end
end