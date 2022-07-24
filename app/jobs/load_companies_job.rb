class LoadCompaniesJob < ApplicationJob
  queue_as :default

  def perform
    command = LoadCompanies.call
    raise "Failed to load companies!" unless command.success?
  end
end
