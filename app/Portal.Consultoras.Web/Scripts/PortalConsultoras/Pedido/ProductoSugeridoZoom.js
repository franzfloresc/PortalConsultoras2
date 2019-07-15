(function (window) {
    function definirZoom() {
        var productoSugeridoZoom = {};
        productoSugeridoZoom.init = function (el) {

            var contenedor = document.querySelector(el);
            var imagenesThumbnail = contenedor.querySelectorAll('.producto_imagen_thumbnail');
            var imagenZoom = document.querySelector('.producto_imagen_zoom');

            imagenesThumbnail.forEach(function (imagenThumbnail) {

                imagenThumbnail.addEventListener('mouseenter', function (e) {
                    imagenZoom.style.left = (imagenThumbnail.getBoundingClientRect().left - 40) + 'px';
                    imagenZoom.classList.add('mostrarImagenZoom');
                    imagenZoom.style.backgroundImage = 'url(' + imagenThumbnail.src + ')';
                    imagenZoom.style.backgroundSize = "250%";
                }, false);

                imagenThumbnail.addEventListener('mousemove', function (e) {

                    var dimensionesImagen = this.getBoundingClientRect();

                    var x = e.clientX - dimensionesImagen.left;
                    var y = e.clientY - dimensionesImagen.top;

                    var xpercent = Math.round(100 / (dimensionesImagen.width / x));
                    var ypercent = Math.round(100 / (dimensionesImagen.height / y));

                    imagenZoom.style.backgroundPosition = xpercent + '% ' + ypercent + '%';

                }, false);

                imagenThumbnail.addEventListener('mouseleave', function (e) {
                    imagenZoom.style.backgroundSize = "90%";
                    imagenZoom.style.backgroundPosition = "center";
                }, false);

                imagenThumbnail.parentNode.addEventListener('mouseleave', function (e) {
                    imagenZoom.classList.remove('mostrarImagenZoom');
                }, false);

            });           

        }
        return productoSugeridoZoom;
    }

    if (typeof (productoSugeridoZoom) === 'undefined') {
        window.productoSugeridoZoom = definirZoom();
    }

})(window);