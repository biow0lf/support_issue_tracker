class ClosedTicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = Ticket.closed_tickets
  end
end
