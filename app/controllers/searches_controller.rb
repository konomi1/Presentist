class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
		@content = params[:content]
    @results = Present.search_for(@content)
    @pagenation = Kaminari.paginate_array(@results).page(params[:page])
  end

end
