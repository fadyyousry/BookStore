module Manager
  class UsersController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

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