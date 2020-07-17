module ApplicationHelper
  def current_user_admin?
    current_user.present? && current_user.admin?
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end
