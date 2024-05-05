import showdown from "showdown";

document.addEventListener("turbo:load", () => {
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
