import showdown from "showdown";

console.log("Hello Preview")

document.addEventListener("DOMContentLoaded", () => {
    let converter = new showdown.Converter();
    let mdElem = document.querySelector("#markdown-content");
    let out = document.querySelector("#preview");

    document.querySelector("#preview-markdown").onclick = () => {
        let markdown = mdElem.value;
        let html = converter.makeHtml(markdown);
        out.innerHTML = html;

        console.log("Yay replaced")
    };
});
