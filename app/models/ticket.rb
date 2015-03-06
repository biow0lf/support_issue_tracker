require 'uid_generator'

class Ticket < ActiveRecord::Base
  belongs_to :status
  has_many :comments, dependent: :destroy
  belongs_to :department
  belongs_to :user

  validates :name, presence: true
  validates :email, presence: true
  validates :summary, presence: true
  validates :body, presence: true
  validates :department, presence: true

  before_create :generate_uid, :set_status
  after_create :send_email_on_ticket_create

  update_index 'tickets#ticket', :self

  def to_param
    uid
  end

  def first_name
    name.split.first
  end

  def self.unassigned_tickets
    where(user_id: nil)
  end

  def self.open_tickets
    exclude_ids = []
    exclude_ids << Status.find_by_name('Cancelled').id
    exclude_ids << Status.find_by_name('Completed').id
    ids = Status.all.map(&:id) - exclude_ids
    where(status_id: ids)
  end

  def self.on_hold_tickets
    Status.find_by_name('On Hold').tickets
  end

  def self.closed_tickets
    ids = []
    ids << Status.find_by_name('Cancelled').id
    ids << Status.find_by_name('Completed').id
    where(status_id: ids)
  end

  private

  def generate_uid
    self.uid ||= UidGenerator.new.generate
  end

  def set_status
    self.status_id ||= Status.find_by_name!('Waiting for Staff Response').id
  end

  def send_email_on_ticket_create
    CreateTicketMailer.email_for(self).deliver_later
  end
end
