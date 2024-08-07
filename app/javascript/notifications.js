document.addEventListener('DOMContentLoaded', function() {
  setTimeout(function() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
      alert.classList.add('fade-out');
      setTimeout(() => alert.remove(), 1000);
    });
  }, 2000);
});
