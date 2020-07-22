module Manager
  class SalesController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    def index
      @sales = Sale.all.order(:payment_time).reverse
    end
  end
end