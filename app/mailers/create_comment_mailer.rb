class CreateCommentMailer < ApplicationMailer
  def email_for(comment)
    @comment = comment
    mail(to: @comment.ticket.email, subject: "[#{ @comment.ticket.uid }] #{ @comment.ticket.summary } -- added comment")
  end
end
