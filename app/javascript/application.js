import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
    const flashMessage = document.querySelector('.flash-message');
    if (flashMessage) {
      setTimeout(function() {
        flashMessage.style.opacity = '0';
      }, 3000);
  
      setTimeout(function() {
        flashMessage.remove();
      }, 4000);
    }
  });
  