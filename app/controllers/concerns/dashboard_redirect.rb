module DashboardRedirect
  extend ActiveSupport::Concern

  def after_sign_in_path_for(user)
    user_dashboard(user)
  end

  def after_sign_up_path_for(user)
    user_dashboard(user)
  end

  def user_dashboard(user)
    user.admin? ? admin_path : root_path
  end
end