class BooksController < ApplicationController
  include Pagy::Backend

  before_action :set_book, only: [:show]

  def index
    @pagy, @books = pagy(
      Book.by_author_and_category(
        params[:author_id],
        params[:category_id]
      ).includes(:author, :publisher, :category)
    )
  end

  def show; end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
