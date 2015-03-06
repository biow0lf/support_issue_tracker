require 'rails_helper'

RSpec.describe UpdateTicketMailer, type: :mailer do
  it 'should send email on ticket update' do
    user_from = FactoryGirl.create(:user)
    status_from = FactoryGirl.create(:status)
    ticket = FactoryGirl.create(:ticket, user_id: user_from.id, status_id: status_from.id)
    status_to = FactoryGirl.create(:status)
    user_to = FactoryGirl.create(:user)
    ticket.update(status_id: status_to.id, user_id: user_to.id)
    email = UpdateTicketMailer.email_for(ticket.id, ticket.previous_changes, user_to.id)
    expect(email).to deliver_to(ticket.email)
    expect(email).to have_subject("[#{ ticket.uid }] #{ ticket.summary } -- updated")
    text = "Hello #{ ticket.first_name },"
    expect(email).to have_body_text(text)
    text = "Ticket with id #{ ticket.uid } was updated."
    expect(email).to have_body_text(text)
    text = "User #{ user_to.email } changed:"
    expect(email).to have_body_text(text)
    text = "Assigned from #{ user_from.email } to #{ user_to.email }."
    expect(email).to have_body_text(text)
    text = "Status from #{ status_from.name } to #{ status_to.name }."
    expect(email).to have_body_text(text)
    text = "Url: #{ ticket_url(ticket) }"
    expect(email).to have_body_text(text)
  end
end
