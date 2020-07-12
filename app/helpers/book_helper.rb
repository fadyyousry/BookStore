module BookHelper
    def csv_names list
        list.pluck(:name).join(',')
    end
end