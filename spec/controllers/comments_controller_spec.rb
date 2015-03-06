require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      context 'and user not logged in' do
        before(:each) do
          @ticket = create(:ticket)
        end

        after(:each) do
          @ticket.destroy
        end

        it 'saves the new comment in the database' do
          expect { post :create, comment: attributes_for(:comment,
                                                         ticket_id: @ticket.id),
                                 ticket: { status_id: @ticket.status_id } }
            .to change(Comment, :count).by(1)
        end

        it 'redirects to tickets#show' do
          post :create, comment: attributes_for(:comment, ticket_id: @ticket.id),
                        ticket: { status_id: @ticket.status_id }
          expect(response).to redirect_to ticket_path(assigns[:comment].ticket)
        end
      end

      context 'and user logged in' do
        before(:each) do
          @ticket = create(:ticket)
          @user = create(:user)
        end

        after(:each) do
          @ticket.destroy
          @user.destroy
        end

        it 'saves the new comment in the database' do
          sign_in @user
          expect { post :create, comment: attributes_for(:comment,
                                                         ticket_id: @ticket.id),
                        ticket: { status_id: @ticket.status_id,
                                  user_id: @user.id } }
              .to change(Comment, :count).by(1)
        end

        it 'redirects to tickets#show' do
          sign_in @user
          post :create, comment: attributes_for(:comment, ticket_id: @ticket.id),
               ticket: { status_id: @ticket.status_id, user_id: @user.id }
          expect(response).to redirect_to ticket_path(assigns[:comment].ticket)
        end
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        @ticket = create(:ticket)
      end

      after(:each) do
        @ticket.destroy
      end

      it 'does not save the new comment in the database' do
        expect { post :create, comment: attributes_for(:invalid_comment, ticket_id: @ticket.id),
                               ticket: { status_id: @ticket.status_id } }
          .not_to change(Comment, :count)
      end

      it 'redirects to tickets#show' do
        post :create, comment: attributes_for(:invalid_comment, ticket_id: @ticket.id),
                      ticket: { status_id: @ticket.status_id }
        expect(response).to redirect_to ticket_path(assigns[:comment].ticket)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @ticket = create(:ticket)
      @comment = create(:comment, ticket: @ticket)
    end

    it 'deletes the comment' do
      expect { delete :destroy, id: @comment }
        .to change(Comment, :count).by(-1)
    end

    it 'redirects to tickets#index' do
      delete :destroy, id: @comment
      expect(response).to redirect_to @comment.ticket
    end
  end
end
