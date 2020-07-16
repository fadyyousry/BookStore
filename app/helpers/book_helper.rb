module BookHelper
    def csv_names(list)
        list.pluck(:name).join(', ')
    end

    def human_boolean(flag)
        flag ? t('default.yes') : t('default.no')
    end
end