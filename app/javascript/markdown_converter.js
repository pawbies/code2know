import showdown from "showdown";

console.log("Hello World")

document.addEventListener("DOMContentLoaded", () => {
    let converter = new showdown.Converter();

    document.querySelectorAll(".markdown-content").forEach((elem) => {
        let markdown = elem.innerHTML;
        let html = converter.makeHtml(markdown);
        elem.innerHTML = html;

        console.log("Yay replaced")
    });
});
