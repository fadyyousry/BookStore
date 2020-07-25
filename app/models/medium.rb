class Medium < ApplicationRecord
  validates :address, presence: true
  validates :call, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :timing, presence: true

  validates :facebook,:format => URI::regexp(%w(http https))
  validates :instagram,:format => URI::regexp(%w(http https))
  validates :twitter,:format => URI::regexp(%w(http https))
  validates :pinterest,:format => URI::regexp(%w(http https))

end
