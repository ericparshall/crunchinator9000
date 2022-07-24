class InitializeCompanyJob < ApplicationJob
  queue_as :default

  def perform(company_id)
    company = Company.find(company_id)
    command = InitializeCompany.call(company)
    raise "Failed to initialize company #{company.name}" unless command.success?
  end
end
