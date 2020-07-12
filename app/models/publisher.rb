class Publisher < ApplicationRecord
    has_many :books
    validates :name, :uniqueness => {:case_sensitive => false}, allow_blank: false
end
