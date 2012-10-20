class SearchController < ApplicationController
  def index
    @verses = Verse.unscoped.text_search(params[:q])
    cookies[:q] = params[:q]
  end
end
