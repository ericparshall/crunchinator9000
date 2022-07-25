class CompaniesController < ApplicationController
  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    redirect_to root_path
  end

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

  private

  def company_params
    params.require(:company).permit(:name, funding_rounds_attributes: [:id, :funding_round_type, :funded_date, :funded_usd, :_destroy])
  end
end
