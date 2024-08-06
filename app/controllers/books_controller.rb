class BooksController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource
  before_action :set_book, only: [:show]

  def index
    @q = Book.ransack(params[:q])
    @pagy, @books = pagy(@q.result)
  end

  def show; end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
