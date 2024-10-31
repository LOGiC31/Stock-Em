import "@hotwired/turbo-rails"
import "controllers"
import Rails from "@rails/ujs";
Rails.start();


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
  