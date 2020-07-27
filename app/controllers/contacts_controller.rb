class ContactsController < ApplicationController
  def new
    UserMailer.contact_email(contact_params).deliver_later
    redirect_to root_path, notice: t('default.messages.thank_for_contact')
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end