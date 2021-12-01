class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]

    # ギフトログを検索.タグも含めて検索。
    @results = Present.includes(:tags).references(:tags).search(@content)
    @pagenation = Kaminari.paginate_array(@results).page(params[:page])


    # 楽天市場から検索
    @items = RakutenWebService::Ichiba::Item.search(keyword: @content).first(5)
  end
end
