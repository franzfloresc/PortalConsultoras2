var xZoomSetup;
$(document).ready(function () {
    'use strict';

    var mainXZ;

    mainXZ = function () {
        var me = this;
        me.Eventos = {
            InicializarEventos: function () {
                $('.xzoom, .xzoom-gallery').xzoom({ zoomWidth: 400, title: true, tint: '#333', Xoffset: 15 });
                $('.xzoom2, .xzoom-gallery2').xzoom({ position: '#xzoom2-id', tint: '#ffa200' });
                $('.xzoom3, .xzoom-gallery3').xzoom({ position: 'lens', lensShape: 'circle', sourceClass: 'xzoom-hidden' });
                $('.xzoom4, .xzoom-gallery4').xzoom({ tint: '#006699', Xoffset: 15 });
                $('.xzoom5, .xzoom-gallery5').xzoom({ tint: '#006699', Xoffset: 15 });
                $(document).on('click', '.rotate', me.Funciones.ImageNormal);
                $(document).on('click', '.rotate90', me.Funciones.Image90Degrees);
                $(document).on('click', '.rotate180', me.Funciones.Image180Degrees);
                $(document).on('click', '.rotate270', me.Funciones.Image270Degrees);
            }
        },
        me.Funciones = {
            Ready: function () {
                //Integration with hammer.js
                var isTouchSupported = 'ontouchstart' in window;
                if (isTouchSupported) {
                    me.Funciones.TouchDevice();
                } else {
                    me.Funciones.NotTouchDevice();
                }
            },
            TouchDevice: function () {
                $('.xzoom, .xzoom2, .xzoom3, .xzoom4, .xzoom5').each(function () {
                    var xzoom = $(this).data('xzoom');
                    xzoom.eventunbind();
                });

                $('.xzoom, .xzoom2, .xzoom3').each(function () {
                    var xzoom = $(this).data('xzoom');
                    $(this).hammer().on("tap", function (event) {
                        event.pageX = event.gesture.center.pageX;
                        event.pageY = event.gesture.center.pageY;

                        xzoom.eventmove = function (element) {
                            element.hammer().on('drag', function (event) {
                                event.pageX = event.gesture.center.pageX;
                                event.pageY = event.gesture.center.pageY;
                                xzoom.movezoom(event);
                                event.gesture.preventDefault();
                            });
                        }

                        xzoom.eventleave = function (element) {
                            element.hammer().on('tap', function (event) {
                                xzoom.closezoom();
                            });
                        }
                        xzoom.openzoom(event);
                    });
                });

                $('.xzoom4').each(function () {
                    var xzoom = $(this).data('xzoom');
                    $(this).hammer().on("tap", function (event) {
                        event.pageX = event.gesture.center.pageX;
                        event.pageY = event.gesture.center.pageY;

                        xzoom.eventmove = function (element) {
                            element.hammer().on('drag', function (event) {
                                event.pageX = event.gesture.center.pageX;
                                event.pageY = event.gesture.center.pageY;
                                xzoom.movezoom(event);
                                event.gesture.preventDefault();
                            });
                        }

                        var counter = 0;
                        xzoom.eventclick = function (element) {
                            element.hammer().on('tap', function () {
                                counter++;
                                if (counter == 1) setTimeout(openfancy, 300);
                                event.gesture.preventDefault();
                            });
                        }

                        function openfancy() {
                            if (counter == 2) {
                                xzoom.closezoom();
                                $.fancybox.open(xzoom.gallery().cgallery);
                            } else {
                                xzoom.closezoom();
                            }
                            counter = 0;
                        }
                        xzoom.openzoom(event);
                    });
                });

                $('.xzoom5').each(function () {
                    var xzoom = $(this).data('xzoom');
                    $(this).hammer().on("tap", function (event) {
                        event.pageX = event.gesture.center.pageX;
                        event.pageY = event.gesture.center.pageY;

                        xzoom.eventmove = function (element) {
                            element.hammer().on('drag', function (event) {
                                event.pageX = event.gesture.center.pageX;
                                event.pageY = event.gesture.center.pageY;
                                xzoom.movezoom(event);
                                event.gesture.preventDefault();
                            });
                        }

                        var counter = 0;
                        xzoom.eventclick = function (element) {
                            element.hammer().on('tap', function () {
                                counter++;
                                if (counter == 1) setTimeout(openmagnific, 300);
                                event.gesture.preventDefault();
                            });
                        }

                        function openmagnific() {
                            if (counter == 2) {
                                xzoom.closezoom();
                                var gallery = xzoom.gallery().cgallery;
                                var i, images = new Array();
                                for (i in gallery) {
                                    images[i] = { src: gallery[i] };
                                }
                                $.magnificPopup.open({ items: images, type: 'image', gallery: { enabled: true } });
                            } else {
                                xzoom.closezoom();
                            }
                            counter = 0;
                        }
                        xzoom.openzoom(event);
                    });
                });
            },
            NotTouchDevice: function () {
                //Integration with fancybox plugin
                $('#xzoom-fancy').bind('click', function (event) {
                    var xzoom = $(this).data('xzoom');
                    xzoom.closezoom();
                    $.fancybox.open(xzoom.gallery().cgallery, { padding: 0, helpers: { overlay: { locked: false } } });
                    event.preventDefault();
                });

                //Integration with magnific popup plugin
                $('#xzoom-magnific').bind('click', function (event) {
                    var xzoom = $(this).data('xzoom');
                    xzoom.closezoom();
                    var gallery = xzoom.gallery().cgallery;
                    var i, images = new Array();
                    for (i in gallery) {
                        images[i] = { src: gallery[i] };
                    }
                    $.magnificPopup.open({ items: images, type: 'image', gallery: { enabled: true } });
                    event.preventDefault();
                });
            },
            ImageNormal: function () {
                $(".rotate").toggleClass('rotate90').removeClass('rotate');
                $(".flip").toggleClass('flip90').removeClass('flip');
            },
            Image90Degrees: function () {
                $(".rotate90").toggleClass('rotate180').removeClass('rotate90');
                $(".flip90").toggleClass('flip180').removeClass('flip90');
            },
            Image180Degrees: function () {
                $(".rotate180").toggleClass('rotate270').removeClass('rotate180');
                $(".flip180").toggleClass('flip270').removeClass('flip180');
            },
            Image270Degrees: function () {
                $(".rotate270").toggleClass('rotate').removeClass('rotate270');
                $(".flip270").toggleClass('flip').removeClass('flip270');
            },
            InicializarImage: function (btn , img) {
                $("#" + btn).removeClassPrefix('rotate').addClass('rotate');
                $("#" + img).removeClassPrefix('flip').addClass('flip');
            }
        },
        me.Inicializar = function () {
            me.Eventos.InicializarEventos();
            me.Funciones.Ready();
        };
    };
    xZoomSetup = new mainXZ();

    xZoomSetup.Inicializar();
});

(function ($) {
    $.fn.removeClassPrefix = function (prefix) {
        this.each(function (i, el) {
            var classes = el.className.split(" ").filter(function (c) {
                return c.lastIndexOf(prefix, 0) !== 0;
            });
            el.className = $.trim(classes.join(" "));
        });
        return this;
    };
})(jQuery);