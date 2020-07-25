module Manager
  class UsersController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    add_breadcrumb I18n.t('default.dashboard'), :manager_root_path
    add_breadcrumb I18n.t('activerecord.models.user.other'), :manager_users_path

    def create
      if @user.save
        redirect_to manager_users_path, notice: t("messages.success.create", model: @user.class.name)
      else
        render 'new'
      end
    end

    def update
      if @user.update(update_user_params)
        redirect_to manager_users_path, notice: t("messages.success.update", model: @user.class.name)
      else
        render 'edit'
      end
    end

    def destroy
      @user.destroy!
      redirect_to manager_users_url, notice: t("messages.success.destroy", model: @user.class.name)
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :type)
    end

    def update_user_params
      params[:user][:password].present? ?
        params.require(:user).permit(:email, :type, :password, :password_confirmation) :
        params.require(:user).permit(:email, :type)
    end
  end
end