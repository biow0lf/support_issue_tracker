require 'rails_helper'

describe SendEmailOnTicketUpdateService do
  before(:each) do
    @ticket = create(:ticket)
    @ticket.reload
    @user = create(:user)
    @mailer = UpdateTicketMailer
  end

  it 'should not update ticket attributes with invalid data' do
    service = SendEmailOnTicketUpdateService.new(@ticket, { name: '' }, @mailer, @user)
    expect(@ticket).to receive(:update).with({ name: '' } ).and_return(false)
    expect(service.execute).to eq(false)
  end

  it 'should update ticket without sending email' do
    name = { name: 'John Snow' }
    service = SendEmailOnTicketUpdateService.new(@ticket, name, @mailer, @user)
    expect(@ticket).to receive(:update).with(name).and_return(true)
    expect(@mailer).not_to receive(:email_for)
    expect(service.execute).to eq(true)
  end

  it 'should update ticket and send email' do
    status = create(:status)
    params = { status_id: status.id, user_id: @user.id }
    message_delivery = instance_double(ActionMailer::MessageDelivery)
    expect(message_delivery).to receive(:deliver_later)
    service = SendEmailOnTicketUpdateService.new(@ticket, params, @mailer, @user)
    expect(@mailer).to receive(:email_for).and_return(message_delivery)
    expect(service.execute).to eq(true)
  end
end
