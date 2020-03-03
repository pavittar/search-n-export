class PagesController < ApplicationController
  def home
    @q1 = Song.ransack(params[:q1], search_key: :q1)
    @songs = @q1.result.includes(:author).limit(10)

    @q2 = Author.ransack(params[:q2], search_key: :q2)
    @authors = @q2.result.limit(10)
  end
end