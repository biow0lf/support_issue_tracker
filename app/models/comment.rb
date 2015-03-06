class Comment < ActiveRecord::Base
  belongs_to :ticket

  validates :ticket, presence: true
  validates :body, presence: true
  validates :name, presence: true
  validates :email, presence: true

  after_create :send_email_on_comment_create

  private

  def send_email_on_comment_create
    CreateCommentMailer.email_for(self).deliver_later
  end
end
