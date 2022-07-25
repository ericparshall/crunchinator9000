class Company < ApplicationRecord
  belongs_to :company_category, required: false
  has_many :funding_rounds, dependent: :delete_all
  paginates_per 15
  accepts_nested_attributes_for :funding_rounds, allow_destroy: true, reject_if: lambda { |attributes|
    attributes['funding_round_type'].blank? || attributes['funded_date'].blank? || attributes['funded_usd'].blank?
  }
end
