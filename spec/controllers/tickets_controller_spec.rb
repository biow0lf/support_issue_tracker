require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all tickets as @tickets' do
      ticket1 = create(:ticket)
      ticket2 = create(:ticket)
      get :index
      expect(assigns(:tickets)).to match_array([ticket1, ticket2])
    end

    it 'render the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ticket as @ticket' do
      ticket = create(:ticket)
      comment1 = create(:comment, ticket: ticket)
      comment2 = create(:comment, ticket: ticket)
      get :show, id: ticket
      expect(assigns(:ticket)).to eq(ticket)
      expect(assigns(:comments)).to eq([comment1, comment2])
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it 'render the :show template' do
      ticket = create(:ticket)
      get :show, id: ticket
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new Ticket to @ticket' do
      get :new
      expect(assigns(:ticket)).to be_a_new(Ticket)
    end

    it 'render the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested ticket as @ticket' do
      ticket = create(:ticket)
      get :edit, id: ticket
      expect(assigns(:ticket)).to eq(ticket)
    end

    it 'render the :edit template' do
      ticket = create(:ticket)
      get :edit, id: ticket
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:all) do
        @status = create(:status)
        @department = create(:department)
      end

      after(:all) do
        Status.delete_all
        Department.delete_all
      end

      it 'saves the new ticket in the database' do
        expect { post :create, ticket: attributes_for(:ticket, status: @status,
                                                      department_id: @department.id) }
          .to change(Ticket, :count).by(1)
      end

      it 'redirects to tickets#show' do
        post :create, ticket: attributes_for(:ticket, status: @status,
                                             department_id: @department.id)
        expect(response).to redirect_to ticket_path(assigns[:ticket])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new ticket in the database' do
        expect { post :create, ticket: attributes_for(:invalid_ticket) }
          .not_to change(Ticket, :count)
      end

      it 're-renders the :new template' do
        post :create, ticket: attributes_for(:invalid_ticket)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      @ticket = create(:ticket,
        email: 'me@example.com',
        summary: 'Test summary',
        body: 'Full description'
      )
    end

    context 'with valid attributes' do
      it 'located the requested @ticket' do
        patch :update, id: @ticket, ticket: attributes_for(:ticket)
        expect(assigns(:ticket)).to eq(@ticket)
      end

      it 'changes @ticket attributes' do
        patch :update, id: @ticket,
          ticket: attributes_for(:ticket,
            email: 'another@example.com',
            summary: 'Updated summary',
            body: 'Updated description'
          )
        @ticket.reload
        expect(@ticket.email).to eq('another@example.com')
        expect(@ticket.summary).to eq('Updated summary')
        expect(@ticket.body).to eq('Updated description')
      end

      it 'redirects to the updated ticket' do
        patch :update, id: @ticket, ticket: attributes_for(:ticket)
        expect(response).to redirect_to @ticket
      end

      it 'should allow logged in user to change assigned to' do
        user = create(:user)
        sign_in user
        patch :update, id: @ticket,
              ticket: attributes_for(:ticket,
                                     email: 'another@example.com',
                                     summary: 'Updated summary',
                                     body: 'Updated description',
                                     user_id: user.id
              )
        @ticket.reload
        expect(@ticket.email).to eq('another@example.com')
        expect(@ticket.summary).to eq('Updated summary')
        expect(@ticket.body).to eq('Updated description')
        expect(@ticket.user.id).to eq(user.id)
      end
    end

    context 'with invalid attributes' do
      it "does not change the ticket's attributes" do
        patch :update, id: @ticket, ticket: attributes_for(:ticket,
          email: nil, summary: nil, body: nil)
        @ticket.reload
        expect(@ticket.email).not_to be_nil
        expect(@ticket.summary).not_to be_nil
        expect(@ticket.body).not_to be_nil

        expect(@ticket.email).to eq('me@example.com')
        expect(@ticket.summary).to eq('Test summary')
        expect(@ticket.body).to eq('Full description')
      end

      it 're-renders the :edit template' do
        patch :update, id: @ticket, ticket: attributes_for(:invalid_ticket)
        expect(response).to render_template :edit
      end
    end
  end

  # TODO: PUT    /tickets/:id(.:format)      tickets#update
  # describe 'PUT #update' do
  # end

  describe 'DELETE #destroy' do
    before(:each) do
      @ticket = create(:ticket)
    end

    it 'deletes the ticket' do
      expect { delete :destroy, id: @ticket }
        .to change(Ticket, :count).by(-1)
    end

    it 'redirects to tickets#index' do
      delete :destroy, id: @ticket
      expect(response).to redirect_to tickets_path
    end
  end
end
