module ApplicationHelper
  def current_user_admin?
    current_user.present? && current_user.admin?
  end

  def current_user_customer?
    current_user.present? && current_user.customer?
  end

  def current_user_own_book?(book)
    current_user_admin? ||
        (current_user_customer? && current_user.books.find_by(id: book.id) && book.pdf_file.attached?)
  end

  def cart_size
    current_user.sales.in_progress.size
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def flash_class type
    if type == "notice"
      "alert alert-success"
    elsif type == "alert" 
      "alert alert-danger"
    else
      "alert alert-#{type}"
    end
  end
end
