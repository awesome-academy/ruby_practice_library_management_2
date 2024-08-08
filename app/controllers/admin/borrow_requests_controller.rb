class Admin::BorrowRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @borrow_requests = BorrowRequest.all
  end

  def update
    @borrow_request = BorrowRequest.find(params[:id])
    if @borrow_request.update(borrow_request_params)
      redirect_to admin_borrow_requests_path, notice:
      "Yêu cầu mượn sách đã được cập nhật."
    else
      render :index
    end
  end

  def batch_update
    BorrowRequest.where(id: params[:borrow_request_ids]).each do |borrow_request|
      status = params["borrow_requests"][borrow_request.id.to_s]["status"]
      rejection_reason = params["borrow_requests"][borrow_request.id.to_s]["rejection_reason"]
      borrow_request.update(status: status, rejection_reason: rejection_reason)
    end
    redirect_to admin_borrow_requests_path, notice:
    "Đã cập nhật trạng thái cho các yêu cầu mượn sách được chọn."
  end

  private

  def admin_required
    redirect_to root_path, alert: "Bạn không có quyền truy cập trang này." unless current_user.admin?
  end

  def borrow_request_params
    params.require(:borrow_request).permit(:status, :rejection_reason)
  end
end
