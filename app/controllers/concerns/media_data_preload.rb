module MediaDataPreload
    extend ActiveSupport::Concern
    included do
        before_action :media_show
    end

    def media_show
        @medium = Medium.first
    end
end