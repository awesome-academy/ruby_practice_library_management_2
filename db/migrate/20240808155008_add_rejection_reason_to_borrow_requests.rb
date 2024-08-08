class AddRejectionReasonToBorrowRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :borrow_requests, :rejection_reason, :text
  end
end
