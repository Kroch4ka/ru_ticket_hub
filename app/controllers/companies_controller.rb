class CompaniesController < ApplicationController
  before_action :authenticate_and_set_user

  def create
    authorize Company
    company = Company.new(company_params)

    if company.save
      # Generate company user and notify through email with email and password
      render json: company, status: :created
    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  def show
    company = Company.find(params[:id])
    render json: company, status: :ok
  end

  def destroy
    authorize Company
    company = Company.find(params[:id])
    company.destroy
  end

  private

  def company_params
    params.require(:company).permit(:name, :website)
  end
end
