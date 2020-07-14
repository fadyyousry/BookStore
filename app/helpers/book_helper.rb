module BookHelper
    def publisher_name publisher
        publisher.name if publisher.persisted?
    end

    def csv_names list
        list.pluck(:name).join(',')
    end
end