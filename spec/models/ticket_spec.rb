require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to :status }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to :department }
    it { is_expected.to belong_to :user }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :summary }
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_presence_of :department }
  end

  context 'DB Indexes' do
    it { is_expected.to have_db_index(:uid).unique }
    it { is_expected.to have_db_index :status_id }
    it { is_expected.to have_db_index :department_id }
    it { is_expected.to have_db_index :user_id }
  end

  it 'should return uid on #to_param' do
    ticket = create(:ticket)
    expect(ticket.to_param).to eq(ticket.uid)
  end

  it 'should set uid before create' do
    ticket = build(:ticket)
    expect(ticket).to receive(:generate_uid).and_call_original
    ticket.save
    expect(ticket.uid).not_to be_nil
  end

  it 'should set status before create' do
    ticket = build(:ticket)
    expect(ticket).to receive(:set_status).and_call_original
    ticket.save
    expect(ticket.status).not_to be_nil
  end

  it 'should send email after successful ticket creation' do
    ticket = build(:ticket)
    expect(ticket).to receive(:send_email_on_ticket_create).and_return(true)
    ticket.save
  end

  context '#first_name' do
    it 'should return #first_name for John Snow' do
      ticket = create(:ticket, name: 'John Snow')
      expect(ticket.first_name).to eq('John')
    end

    it 'should return #first_name for Jane' do
      ticket = create(:ticket, name: 'Jane')
      expect(ticket.first_name).to eq('Jane')
    end
  end

  context '.unassigned_tickets' do
    before(:all) do
      @ticket1 = create(:ticket)
      @ticket2 = create(:ticket)
      @user = create(:user)
      @ticket3 = create(:ticket, user_id: @user.id)
    end

    after(:all) do
      Ticket.delete_all
      User.delete_all
    end

    it 'should return all unassigned tickets' do
      expect(Ticket.unassigned_tickets).to eq([@ticket1, @ticket2])
    end

    it 'should not return assigned tickets' do
      expect(Ticket.unassigned_tickets).to_not include(@ticket3)
    end
  end

  context '.open_tickets' do
    before(:all) do
      @status_waiting = create(:status, name: 'Waiting')
      @status_on_hold = create(:status, name: 'On Hold')
      @status_cancelled = create(:status, name: 'Cancelled')
      @status_completed = create(:status, name: 'Completed')

      @ticket1 = create(:ticket, status_id: @status_waiting.id)
      @ticket2 = create(:ticket, status_id: @status_on_hold.id)
      @ticket3 = create(:ticket, status_id: @status_cancelled.id)
      @ticket4 = create(:ticket, status_id: @status_completed.id)
    end

    after(:all) do
      Ticket.delete_all
      Status.delete_all
    end

    it 'should return all opened tickets' do
      expect(Ticket.open_tickets).to eq([@ticket1, @ticket2])
    end

    it 'should not return cancelled or completed tickets' do
      expect(Ticket.open_tickets).to_not eq([@ticket3, @ticket4])
    end
  end

  context '.on_hold_tickets' do
    before(:all) do
      @status_waiting = create(:status, name: 'Waiting')
      @status_on_hold = create(:status, name: 'On Hold')
      @ticket1 = create(:ticket, status_id: @status_waiting.id)
      @ticket2 = create(:ticket, status_id: @status_on_hold.id)
      @ticket3 = create(:ticket, status_id: @status_on_hold.id)
    end

    after(:all) do
      Ticket.delete_all
      Status.delete_all
    end

    it 'should return all tickets with status On Hold' do
      expect(Ticket.on_hold_tickets).to eq([@ticket2, @ticket3])
    end

    it 'should not return other tickets' do
      expect(Ticket.on_hold_tickets).to_not eq([@ticket1])
    end
  end

  context '.closed_tickets' do
    before(:all) do
      @status_waiting = create(:status, name: 'Waiting')
      @status_on_hold = create(:status, name: 'On Hold')
      @status_cancelled = create(:status, name: 'Cancelled')
      @status_completed = create(:status, name: 'Completed')

      @ticket1 = create(:ticket, status_id: @status_waiting.id)
      @ticket2 = create(:ticket, status_id: @status_on_hold.id)
      @ticket3 = create(:ticket, status_id: @status_cancelled.id)
      @ticket4 = create(:ticket, status_id: @status_completed.id)
    end

    after(:all) do
      Ticket.delete_all
      Status.delete_all
    end

    it 'should return all closed tickets' do
      expect(Ticket.closed_tickets).to eq([@ticket3, @ticket4])
    end

    it 'should not return all other tickets' do
      expect(Ticket.closed_tickets).to_not eq([@ticket1, @ticket2])
    end
  end

  context 'search and index' do
    before(:each) do
      TicketsIndex.purge!
    end

    it 'should add ticket to index' do
      ticket = build(:ticket)
      expect { ticket.save! }.to update_index('tickets#ticket')
    end

    it 'should remove ticket from index' do
      ticket = create(:ticket)
      expect { ticket.destroy! }.to update_index('tickets#ticket')
        .and_delete(ticket)
    end

    it 'should reindex ticket on update' do
      ticket = create(:ticket)
      ticket.summary = 'Updated summary'
      expect { ticket.save! }.to update_index('tickets#ticket')
        .and_reindex(ticket, with: { summary: 'Updated summary' })
    end
  end
end
