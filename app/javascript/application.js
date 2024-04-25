// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


window.onload = () => {
    let flash = document.getElementsByClassName("flash");
    console.log(flash);
    flash.forEach(msg => {
        msg.onclick = (evt) => {
            console.log("clicked");
        }  
    });
}