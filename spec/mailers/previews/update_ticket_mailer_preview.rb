# Preview all emails at http://localhost:3000/rails/mailers/update_ticket_mailer
class UpdateTicketMailerPreview < ActionMailer::Preview
  def email_for
    ticket = FactoryGirl.create(:ticket)
    status = FactoryGirl.create(:status)
    user = FactoryGirl.create(:user)
    ticket.update(status_id: status.id, user_id: user.id)
    UpdateTicketMailer.email_for(ticket.id, ticket.previous_changes, user.id)
  end
end
