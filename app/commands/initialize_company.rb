class InitializeCompany
  prepend SimpleCommand

  attr_reader :company

  def initialize(company)
    @company = company
  end

  def call
    service = CrunchbaseService.new

    service.find_company_rounds(company.permalink) do |round|
      company.funding_rounds.find_or_create_by(
        funding_round_type: round["funding_round_type"],
        funded_date: round["funded_at"],
        funded_usd: round["raised_amount_usd"].to_i
      )
    end

    if company.funding_rounds.any? {|fr| fr.funding_round_type =~ /series.*/ }
      company.destroy
    else
      company.update(fully_initialized: true)
    end
  end
end
