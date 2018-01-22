function Descargables(url, nombre) {
    var link = document.createElement("a");
    link.setAttribute("id", "dwnarchivo")
    link.setAttribute("target", "_blank");
    link.setAttribute('style', 'display:none;');
    link.download = nombre;
    link.href = url;
    document.body.appendChild(link);
    link.click();

    document.body.removeChild(link);
}