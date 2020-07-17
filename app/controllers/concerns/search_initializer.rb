module SearchInitializer
  extend ActiveSupport::Concern

  included do
    before_action :set_search
  end

  def set_search
    @q = Book.ransack(params[:q])
  end
end