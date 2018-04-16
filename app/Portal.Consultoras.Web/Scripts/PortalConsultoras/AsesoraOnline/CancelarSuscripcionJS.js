(function () {
        var url = window.location;      
        var pais = url.href.substring(url.href.indexOf("pais=")+5, url.href.indexOf("pais=") + 7);
    if (pais == 'CR' || pais == 'PA' || pais == 'MX' || pais == 'PR') {
        var css = document.createElement('link');
        css.setAttribute("rel", "stylesheet");
        css.setAttribute("href", "/Content/Css/Site/Lbel/unsubscribe.css");
        document.getElementsByTagName('head')[0].appendChild(css);
    } else {
        var css = document.createElement('link');
        css.setAttribute("rel", "stylesheet");
        css.setAttribute("href", "/Content/Css/Site/Esika/unsubscribe.css");     
        document.getElementsByTagName('head')[0].appendChild(css);
    }
}());

var urlBase;
window.onload = function () {
    urlBase = window.location.protocol + "//" + window.location.host + document.getElementById("hdfRaiz").value;
    sessionStorage.setItem("urlBase", urlBase);

    var pais = document.getElementById("Pais").value;
    var codConsultora = document.getElementById("CodConsultora").value;

    window.localStorage.setItem("Pais", pais);
    window.localStorage.setItem("CodConsultora", codConsultora);

    if (document.getElementById("Resultado").value!="" ) {
        document.getElementById('divContent').style.display = 'Block';
    } 

    if (document.getElementById('linkRegresarAqui')!=null) {
        document.getElementById('linkRegresarAqui').onclick = function () {
            this.href = urlBase + "AsesoraOnline/VolverSuscripcion?pais=" + pais + "&codConsultora=" + codConsultora;
        }

    }

}