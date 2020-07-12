class Author < ApplicationRecord
    has_and_belongs_to_many :books
    validates :name, :uniqueness => {:case_sensitive => false}, allow_blank: false
end
