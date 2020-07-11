class Publisher < ApplicationRecord
    has_many :books
    validates :name, uniqueness:  true, allow_blank: false
end
