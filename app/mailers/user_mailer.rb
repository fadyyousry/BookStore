class UserMailer < ApplicationMailer
	require 'open-uri'

	def welcome_email
		@user = params[:user]
		mail(to: @user.email, subject: 'Welcome to BookStore')
	end

	def receipt_email
		@user = params[:user]
		@receipt = open(params[:url]).read
		mail(to: @user.email, subject: 'Your BookStore Receipt')
	end
end
