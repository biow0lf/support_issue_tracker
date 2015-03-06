require 'rails_helper'

RSpec.describe CreateCommentMailer, type: :mailer do
  it 'should send email on creating comment' do
    comment = create(:comment)
    email = CreateCommentMailer.email_for(comment)
    expect(email).to deliver_to(comment.ticket.email)
    expect(email).to have_subject("[#{ comment.ticket.uid }] #{ comment.ticket.summary } -- added comment")
    text = "Hello #{ comment.ticket.first_name },"
    expect(email).to have_body_text(text)
    text = "#{ comment.name } (#{ comment.email }) added comment"
    expect(email).to have_body_text(text)
    text = "to ticket [#{ comment.ticket.uid }] #{ comment.ticket.summary }."
    expect(email).to have_body_text(text)
    text = "Comment:\n#{ comment.body }"
    expect(email).to have_body_text(text)
  end
end
