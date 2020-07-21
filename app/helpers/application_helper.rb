module ApplicationHelper
  def current_user_admin?
    current_user.present? && current_user.admin?
  end

  def current_user_customer?
    current_user.present? && current_user.customer?
  end

  def cart_size
    current_user.sales.in_progress.size
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end
