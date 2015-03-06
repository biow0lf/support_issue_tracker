class OpenTicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = Ticket.open_tickets
  end
end
