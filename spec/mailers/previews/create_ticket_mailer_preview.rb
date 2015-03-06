# Preview all emails at http://localhost:3000/rails/mailers/create_ticket_mailer
class CreateTicketMailerPreview < ActionMailer::Preview
  def email_for
    ticket = FactoryGirl.create(:ticket)
    CreateTicketMailer.email_for(ticket)
  end
end
