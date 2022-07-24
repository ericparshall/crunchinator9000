class CompaniesController < ApplicationController
  def delete_all
    Company.delete_all
    PendingJob.where(name: "LoadCompanies").delete_all
    redirect_to root_path
  end

  def refresh
    PendingJob.find_or_create_by(name: "LoadCompanies")
    LoadCompaniesJob.perform_later
    redirect_to root_path
  end
end
