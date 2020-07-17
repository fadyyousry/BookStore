module ApplicationHelper
  def current_user_admin?
    current_user.present? && current_user.admin?
  end

  def success_notice(obj)
    t("t")
  end
end
