require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "aasm events" do
    let(:ticket) { create(:ticket) }
    let(:action) { ticket.send(event, *args) }
    let(:event) { :take_to_work! }
    let(:operator) { create(:user, :operator) }
    let(:args) { [ticket, operator] }

    describe "reply" do
      before do
        ticket.update!(operator_id: operator.id)
      end

      context "когда отвечает по тикету оператор" do
        before { ticket.update!(aasm_state: :active) }

        let(:event) { :reply! }
        let(:args) { [ticket.operator] }

        it "происходит переход в статус waiting_reply" do
          action
          expect(ticket.reload).to be_waiting_reply
        end
      end

      context "когда отвечает по тикету клиент" do
        before { ticket.update!(aasm_state: :waiting_reply) }

        let(:event) { :reply! }
        let(:args) { [ticket.customer] }

        it "происходит переход в статус active" do
          action
          expect(ticket.reload).to be_active
        end
      end
    end

    it "присваивает оператора когда он берёт тикет в работу" do
      expect { action }.to change { ticket.operator }.from(nil).to(operator)
    end
  end
end
