# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe 'GET #index' do
    it'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:ticket) { create(:ticket) }
    it'returns a success response' do
      get :show, params: { id: ticket.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:ticket) }
      it 'creates a new Ticket' do
        expect do
          post :create, params: { ticket: valid_attributes }
          expect(response).to have_http_status(:redirect)
          expect(Ticket.count).to eq(1)
          expect(Ticket.last.title).to eq(valid_attributes[:title])
          expect(Ticket.last.description).to eq(valid_attributes[:description])
          expect(Ticket.last.status).to eq(valid_attributes[:status])
          expect(Ticket.last.priority).to eq(valid_attributes[:priority])
          expect(Ticket.last.created_by).to eq(valid_attributes[:created_by])
          expect(Ticket.last.assigned_to).to eq(valid_attributes[:assigned_to])
          expect(Ticket.last.due_date).to eq(valid_attributes[:due_date])
          expect(Ticket.last.updated_by).to eq(valid_attributes[:updated_by])
          expect(Ticket.last.closed_at).to be_nil
          expect(Ticket.last.closed_by).to be_nil
          expect(Ticket.last.comments).to be_empty
          expect(Ticket.last.attachments).to be_empty
          expect(Ticket.last.activities).to be_empty
        end.to change(Ticket, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:ticket) { create(:ticket) }
    it 'destroys the requested ticket' do
      expect do
        delete :destroy, params: { id: ticket.id }
      end.to change(Ticket, :count).by(-1)
    end
  end
end
