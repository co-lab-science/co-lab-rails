class SearchesController < ApplicationController
  def search
    page = params[:page] || 1
    @search_results = Searchable.search(params[:search_term]).paginate(per_page: 50, page: params["page"])
    render 'search/index'
  end
end

