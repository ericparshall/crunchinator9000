class LoadCompanies
  prepend SimpleCommand

  def initialize
    @company_categories = CompanyCategory.all.each_with_object({}) { |cc, hash| hash[cc.name] == cc }
  end

  def call
    companies_found = 0

    pending_job = PendingJob.find_or_create_by(name: "LoadCompanies")

    service = CrunchbaseService.new

    service.find_companies do |crunchbase_company|
      next unless crunchbase_company["funding_rounds"].to_i == 1
      next if Company.exists?(permalink: crunchbase_company["permalink"])
      break if companies_found >= 50

      company = Company.find_or_create_by!(
        permalink: crunchbase_company["permalink"]
      )
      company.update!(
        name: crunchbase_company["name"],
        status: crunchbase_company["status"],
        company_category: get_company_category(crunchbase_company["category_code"]),
        fully_initialized: false
      )

      InitializeCompanyJob.perform_later(company.id)
      companies_found += 1
    end

    pending_job.delete
  end

  private

  def get_company_category(category)
    return @company_categories[category] if @company_categories[category]

    company_category = CompanyCategory.find_or_create_by(name: category)
    @company_categories[category] = company_category

    company_category
  end
end
