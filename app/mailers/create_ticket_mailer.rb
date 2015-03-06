class CreateTicketMailer < ApplicationMailer
  def email_for(ticket)
    @ticket = ticket
    mail(to: @ticket.email, subject: "[#{ @ticket.uid }] #{ @ticket.summary }")
  end
end
