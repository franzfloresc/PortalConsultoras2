var ComponenteDetalleModule = (function () {

    var _setHandlebars = function (idTemplate, modelo) {
        SetHandlebars("#" + idTemplate, modelo, _template.getTagDataHtml(idTemplate));
    };

    var _template = {
        getTagDataHtml: function (templateId) {
            return "[data-ficha-contenido=" + templateId + "]";
        },
        componenteDetalle: "componenteDetalle-template"
    };

    var _VerDetalle = function (cuv) {
        alert('cuv: '+cuv);
        console.log('cuv', cuv);

        _setHandlebars(_template.componenteDetalle, { codigo: 123, nombre: 'dddddddddd' });

        _setAcordionDetalleComponente();         
        $("#modal_producto_detalle").modal();
        _FijarCarrusel();
         
    };

    var _FijarCarrusel = function () {

        $('#carouselVideo').slick({
            infinite: false,
            speed: 300,
            slidesToShow: 1,
            centerMode: false,
            variableWidth: true
        });

    };
     
    var _setAcordionDetalleComponente = function () {
        $("#mnuDetalleComponente li a").click(function () {
            var $this = $(this);
            $this.parent().children("ul").slideToggle();
            var clase = $this.attr("class");
            if (clase === "active") {
                $this.attr("class", "tab-link");
            }
            else {
                $this.attr("class", "active");
                

            }
        });
    };
 
    return {
        VerDetalle: _VerDetalle 
    };
});