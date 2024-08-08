module ApplicationHelper
  def status_row_class(status)
    case status
    when "pending"
      "table-warning"
    when "approved"
      "table-success"
    when "rejected"
      "table-danger"
    else
      "table-secondary"
    end
  end
end
