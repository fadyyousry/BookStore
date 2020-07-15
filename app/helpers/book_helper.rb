module BookHelper
    def csv_names(list)
        list.pluck(:name).join(', ')
    end

    def human_boolean(boolean)
        boolean ? 'Yes' : 'No'
    end
end