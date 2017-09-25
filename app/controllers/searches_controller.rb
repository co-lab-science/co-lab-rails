class SearchesController < ApplicationController
  def search
    page = params[:page] || 1
    sort = params[:sort].present? ? params[:sort] : 'upvote_count'
    filter = params[:filter] || 'all'

    search_results = Searchable.search(params[:search_term]).sort_by!{|x| x.send(sort_map(sort)) }.reverse!

    filter = 'Lab' if filter == 'observation'

    if filter != 'all'
      @search_results = search_results.select{|x| x.class.name == filter.capitalize }.paginate(per_page: 50, page: page)
    else
      @search_results = search_results.paginate(per_page: 50, page: page)
    end

    render 'search/index'
  end

  private

  def sort_map(sort_term)
    sort_terms = {
      "upvote_count"=>"upvote_count",
      "newest"=>"created_at",
      "popularity by upvote"=> "upvote_count",
      "popularity by likes"=> "like_count"
    }

    sort_terms[sort_term]
  end
end

