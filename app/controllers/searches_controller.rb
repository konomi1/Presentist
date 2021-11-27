class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]

    # ギフトログを検索
    @results = Present.search_for(@content)
    @pagenation = Kaminari.paginate_array(@results).page(params[:page])

    # 楽天市場から検索
    @items = RakutenWebService::Ichiba::Item.search(keyword: @content).first(5)
  end
end
