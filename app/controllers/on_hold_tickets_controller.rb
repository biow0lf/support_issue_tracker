class OnHoldTicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = Ticket.on_hold_tickets
  end
end
