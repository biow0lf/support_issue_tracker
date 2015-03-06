require 'rails_helper'

RSpec.describe 'tickets/new', type: :view do
  include Devise::TestHelpers

  before(:each) do
    assign(:ticket, build(:ticket,
      name: 'John Snow',
      email: 'me@example.com',
      summary: 'Short description',
      body: 'Long description'
    ))
  end

  it 'renders new ticket form' do
    render

    assert_select 'form[action=?][method=?]', tickets_path, 'post' do
      assert_select 'input#ticket_name[name=?]', 'ticket[name]'
      assert_select 'input#ticket_email[name=?]', 'ticket[email]'
      assert_select 'select#ticket_department_id[name=?]', 'ticket[department_id]'
      assert_select 'input#ticket_summary[name=?]', 'ticket[summary]'
      assert_select 'textarea#ticket_body[name=?]', 'ticket[body]'
    end
  end
end
