class UpdateTicketMailer < ApplicationMailer
  def email_for(ticket_id, changes, user_id)
    @ticket = Ticket.find_by_id(ticket_id)
    @changes = changes
    @user = User.find_by_id(user_id)
    mail(to: @ticket.email, subject: "[#{ @ticket.uid }] #{ @ticket.summary } -- updated")
  end
end
