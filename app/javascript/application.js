// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import hljs from "highlight.js";
import showdown from "showdown";

document.addEventListener('turbo:load', function() {
  const selectElements = document.querySelectorAll('.selectize');
  selectElements.forEach(function(selectElement) {
    $(selectElement).selectize({
        delimiter: " - ",
        persist: false,
    });
  });
});

document.addEventListener("turbo:load", () => {
    let converter = new showdown.Converter();

    document.querySelectorAll(".markdown-content").forEach((elem) => {
        let markdown = elem.innerHTML;
        let html = converter.makeHtml(markdown);
        elem.innerHTML = html;
    });

    hljs.highlightAll();
});

document.addEventListener("turbo:load", () => {
    let converter = new showdown.Converter();
    let mdElem = document.querySelector("#markdown-content");
    let out = document.querySelector("#preview");

    let prev = document.querySelector("#preview-markdown");
    if (prev == null) return;

    prev.onclick = () => {
        let markdown = mdElem.value;
        let html = converter.makeHtml(markdown);
        out.innerHTML = html;
    };
});
