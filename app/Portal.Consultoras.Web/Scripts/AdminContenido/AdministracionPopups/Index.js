var VistaAdministracionPopups;

$(document).ready(function () {

    var vistaAdPop;

    vistaAdPop = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $('body').on('click', '.btn__agregar, .enlace__editar', me.Eventos.AbrirPopup);
                $('body').on('click', '.btn__modal--guardar, .btn__modal--descartar', me.Eventos.CerrarPopup);
            }
        },
        me.Eventos = {
            AbrirPopup: function (e) {
                e.preventDefault();
                $('#modalTitulo').html($(this).attr('title'));
                $('#AgregarPopup').fadeIn(100);
                $('#AgregarPopup').scrollTop(0);
                $('#AgregarPopup').css('display', 'flex');
                $('body').css('overflow-y', 'hidden');
            },
            CerrarPopup: function (e) {
                e.preventDefault();
                $('#AgregarPopup').fadeOut(100);
                $('body').css('overflow-y', '');
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    VistaAdministracionPopups = new vistaAdPop();
    VistaAdministracionPopups.Inicializar();
});