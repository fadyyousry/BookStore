class UserMailer < ApplicationMailer
  require 'open-uri'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: t('emails.subjects.welcome'))
  end

  def receipt_email
    @user = params[:user]
    @receipt = open(params[:url]).read
    mail(to: @user.email, subject: t('emails.subjects.receipt'))
  end

  def contact_email(contact)
    @contact = contact
    mail( to: ENV["ADMIN_EMAIL"], subject: t('emails.subjects.contact'))
  end
end
