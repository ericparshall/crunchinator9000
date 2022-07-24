class HomeController < ApplicationController
  def index
    @companies = Company.includes(:funding_rounds).order(:name).page params[:page]
  end
end
