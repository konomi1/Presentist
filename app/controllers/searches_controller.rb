class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
		@content = params[:content]
    @results = Present.search_for(@content)
  end

end
