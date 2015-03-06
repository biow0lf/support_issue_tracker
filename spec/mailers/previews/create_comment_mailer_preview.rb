# Preview all emails at http://localhost:3000/rails/mailers/create_comment_mailer
class CreateCommentMailerPreview < ActionMailer::Preview
  def email_for
    comment = FactoryGirl.create(:comment)
    CreateCommentMailer.email_for(comment)
  end
end
