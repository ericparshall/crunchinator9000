class Company < ApplicationRecord
  belongs_to :company_category, required: false
  has_many :funding_rounds, dependent: :delete_all
  paginates_per 15
end
