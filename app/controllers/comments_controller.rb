class CommentsController < ApplicationController
  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    service = SendEmailOnTicketUpdateService.new(
      @comment.ticket, ticket_params, UpdateTicketMailer, current_user)

    if @comment.save && service.execute
      redirect_to @comment.ticket, notice: 'Comment was successfully created.'
    else
      redirect_to @comment.ticket, alert: 'Can not create comment.'
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.ticket, notice: 'Comment was successfully destroyed.'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:name, :email, :body, :ticket_id)
  end

  def ticket_params
    if current_user
      params.require(:ticket).permit(:status_id, :user_id)
    else
      params.require(:ticket).permit(:status_id)
    end
  end
end
