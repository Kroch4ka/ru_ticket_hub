class TicketsController < ApplicationController
  before_action :authenticate_and_set_user

  def create
    return render json: { message: "Not exist or active" }, status: :unprocessable_content unless company&.active?
    company_user = CompanyUser.find_by(user_id: current_user.id, company_id: company.id)
    return render json: { message: "Not authorized" }, status: :unprocessable_content unless company_user

    ticket = Ticket.create(ticket_params)
    if ticket.persisted?
      render json: ticket, status: :created
    else
      render json: { errors: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    ticket = Ticket.find_by(id: params[:id], company_id: company.id)
    return render json: { message: "Not found" }, status: :not_found unless ticket

    if ticket.update(ticket_params)
      render json: ticket, status: :ok
    else
      render json: { errors: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    ticket = Ticket.find_by(id: params[:id], company_id: company.id)
    return render json: { message: "Not found" }, status: :not_found unless ticket

    ticket.destroy
  end

  def show
    ticket = Ticket.find_by(id: params[:id], company_id: company.id)
    return render json: { message: "Not found" }, status: :not_found unless ticket

    render json: ticket, status: :ok
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :body)
  end

  def company = @company ||= Company.find_by(id: params[:company_id])
end
