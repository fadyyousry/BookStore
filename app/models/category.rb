class Category < ApplicationRecord
    has_and_belongs_to_many :books
    validates :name, uniqueness:  true, allow_blank: false
end
