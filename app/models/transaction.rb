class Transaction < ApplicationRecord
  belongs_to :dentist
  belongs_to :customer
end
