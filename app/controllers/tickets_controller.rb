class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1
  def show
    @comments = @ticket.comments.all
    @comment = @ticket.comments.build
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tickets/1
  def update
    result = SendEmailOnTicketUpdateService.new(
      @ticket, ticket_params, UpdateTicketMailer, current_user).execute
    if result
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find_by_uid(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    if current_user
      params.require(:ticket).permit(:name, :email, :summary, :body, :department_id, :status_id, :user_id)
    else
      params.require(:ticket).permit(:name, :email, :summary, :body, :department_id, :status_id)
    end
  end
end
