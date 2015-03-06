class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:q]
      @tickets = TicketsSearch.new(params[:q]).search.load
    else
      @tickets = []
    end
  end
end
