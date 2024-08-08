function toggleRejectionReason(selectElement) {
  const row = selectElement.closest('tr');
  const rejectionReasonElement = row.querySelector('.rejection-reason');

  if (selectElement.value === 'rejected') {
    rejectionReasonElement.style.display = 'block';
  } else {
    rejectionReasonElement.style.display = 'none';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.status-select').forEach(function(selectElement) {
    toggleRejectionReason(selectElement);
  });

  document.addEventListener('change', function(event) {
    if (event.target.classList.contains('status-select')) {
      toggleRejectionReason(event.target);
    }
  });
});
