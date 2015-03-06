class UnassignedTicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = Ticket.unassigned_tickets
  end
end
