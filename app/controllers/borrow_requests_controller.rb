class BorrowRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:new, :create]
  before_action :set_borrow_request, only: [:cancel, :new]
  before_action :check_if_request_pending, only: [:cancel]
  before_action :set_status, only: [:index]
  before_action :fetch_borrow_requests, only: [:index]

  STATUS_LABELS = {
    "pending" => "Đang chờ",
    "approved" => "Đã duyệt",
    "rejected" => "Từ chối",
    "canceled" => "Đã hủy"
  }.freeze

  helper_method :status_label

  def status_label status
    STATUS_LABELS[status] || "Không xác định"
  end

  def new
    @borrow_request = @book.borrow_requests.new
  end

  def create
    return redirect_to books_path, alert: "Không tìm thấy sách." if @book.nil?

    @borrow_request = @book.borrow_requests.new(borrow_request_params)
    @borrow_request.user = current_user

    if @borrow_request.save
      redirect_to @book, notice: "Yêu cầu mượn sách đã được tạo."
    else
      render :new
    end
  end

  def index; end

  def cancel
    @borrow_request.update(status: "canceled")
    redirect_to user_borrow_requests_path(current_user),
                notice: "Yêu cầu mượn sách đã được hủy."
  end

  private

  def set_status
    @status = params[:status]
  end

  def fetch_borrow_requests
    @borrow_requests = current_user.borrow_requests
                                   .includes(:book)
                                   .by_status(@status)
                                   .ordered
  end

  def set_book
    @book = Book.find_by(id: params[:book_id])
    redirect_to books_path, alert: "Không tìm thấy sách." if @book.nil?
  end

  def set_borrow_request
    if @book
      @borrow_request = @book.borrow_requests.new
    else
      @borrow_request = BorrowRequest.find_by(id: params[:id])
      if @borrow_request.nil?
        redirect_to user_borrow_requests_path(current_user),
                    alert: "Yêu cầu mượn sách không tồn tại."
      end
    end
  end

  def check_if_request_pending
    return if @borrow_request&.pending?

    redirect_to user_borrow_requests_path(current_user), alert:
    "Không thể hủy yêu cầu này."
  end

  def borrow_request_params
    params.require(:borrow_request)
          .permit(:start_date, :end_date, book_attributes: [:id])
  end
end
