module Manager
  class UsersController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    def destroy
        @user.destroy!
    end
  end
end