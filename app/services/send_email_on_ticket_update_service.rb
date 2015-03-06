require 'update_ticket_mailer'

class SendEmailOnTicketUpdateService
  attr_reader :ticket, :ticket_params, :mailer, :user

  def initialize(ticket, ticket_params, mailer, user)
    @ticket = ticket
    @ticket_params = ticket_params
    @mailer = mailer
    @user = user
  end

  def execute
    return false unless ticket.update(ticket_params)
    unless changes.empty?
      mailer.email_for(ticket.id, changes, user_id).deliver_later
    end
    true
  end

  private

  def changes
    output = ticket.previous_changes.dup
    output.keep_if { |key, _value| %w(user_id status_id).include?(key) }
  end

  def user_id
    if user
      user.id
    else
      nil
    end
  end
end
