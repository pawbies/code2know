import showdown from "showdown";
import hljs from "highlight.js";

document.addEventListener("turbo:load", () => {
    let converter = new showdown.Converter();

    document.querySelectorAll(".markdown-content").forEach((elem) => {
        let markdown = elem.innerHTML;
        let html = converter.makeHtml(markdown);
        elem.innerHTML = html;
    });

    hljs.highlightAll();
});
