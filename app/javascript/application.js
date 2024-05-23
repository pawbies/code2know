// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener('DOMContentLoaded', function() {
  const selectElements = document.querySelectorAll('.selectize');
  selectElements.forEach(function(selectElement) {
    $(selectElement).selectize({
        delimiter: " - ",
        persist: false,
    });
  });
});
