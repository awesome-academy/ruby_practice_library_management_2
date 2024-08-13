class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @total_borrow_requests = BorrowRequest.count
    @pending_borrow_requests = BorrowRequest.pending.count
    @approved_borrow_requests = BorrowRequest.approved.count
    @rejected_borrow_requests = BorrowRequest.rejected.count
  end

  private

  def admin_required
    redirect_to root_path, alert: "Bạn không có quyền truy cập trang này." unless current_user.admin?
  end
end
