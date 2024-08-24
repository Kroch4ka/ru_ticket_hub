class TicketsController < ApplicationController
  # generate crud endpoints for tickets

  def index
    tickets = Ticket.all
    render json: tickets, status: :ok
  end

  def create
    ticket = Ticket.new(ticket_params)

    if ticket.save
      render json: ticket, status: :created
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  def show
    ticket = Ticket.find(params[:id])
    render json: ticket, status: :ok
  end

  def update
    ticket = Ticket.find(params[:id])

    if ticket.update(ticket_params)
      render json: ticket, status: :ok
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
