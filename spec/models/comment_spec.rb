require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to :ticket }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of :ticket }
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
  end

  context 'DB Indexes' do
    it { is_expected.to have_db_index :ticket_id }
  end

  it 'should send email after successful comment creation' do
    comment = build(:comment)
    expect(comment).to receive(:send_email_on_comment_create).and_return(true)
    comment.save
  end
end
