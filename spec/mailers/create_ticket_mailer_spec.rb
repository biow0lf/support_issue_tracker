require 'rails_helper'

RSpec.describe CreateTicketMailer, type: :mailer do
  it 'should send email on creating ticket' do
    ticket = create(:ticket)
    email = CreateTicketMailer.email_for(ticket)
    expect(email).to deliver_to(ticket.email)
    expect(email).to have_subject("[#{ ticket.uid }] #{ ticket.summary }")
    text = "Hello #{ ticket.first_name },"
    expect(email).to have_body_text(text)
    text = "Ticket with id #{ ticket.uid } created."
    expect(email).to have_body_text(text)
    text = "Summary: #{ ticket.summary }"
    expect(email).to have_body_text(text)
    text = "Department: #{ ticket.department.name }"
    expect(email).to have_body_text(text)
    text = "Text:\n#{ ticket.body }"
    expect(email).to have_body_text(text)
    text = "Url: #{ ticket_url(ticket) }"
    expect(email).to have_body_text(text)
  end
end
