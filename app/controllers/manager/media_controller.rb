module Manager
  class MediaController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    def index
      @medium = Medium.first_or_initialize
      if @medium.persisted?
        render :show
      else
        render :new
      end
    end

    def create
      if @medium.save
        redirect_to manager_media_path, notice: t("messages.success.create", model: @medium.class.name)
      else
        render :new
      end
    end

    def update
      if @medium.update(medium_params)
        redirect_to manager_media_path, notice: t("messages.success.update", model: @medium.class.name)
      else
        render :edit
      end
    end

    private
      def medium_params
        params.require(:medium).permit(:address, :call, :email,
           :timing, :facebook, :instagram, :twitter, :pinterest)
      end
  end
end