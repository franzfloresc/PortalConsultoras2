var MiPerfil;
var marker;
var map;
var directionsService;
var searchBox;
var _googleMap;
var OperacionDb = { Insertar: "0", Editar: "1" };
$(document).ready(function () {
    
    if(EsMobile=='True')
       $('.enlace_abrir_mapa')[0].disabled = true;
 
    var vistaMiPerfil;
    
    vistaMiPerfil = function () {
        var me = this;
        me.Propiedades = {

            latitudIni: 0,
            longitudIni: 0,
            latitudFin: 0,
            longitudFin: 0,
            directionText: '',
            viewport: null
        }
        me.Funciones = {
          
            InicializarEventos: function () {
                $('body').on('blur', '.grupo_form_cambio_datos input, .grupo_form_cambio_datos select', me.Eventos.LabelActivo);
                $('body').on('click', '.enlace_agregar_num_adicional', me.Eventos.AgregarOtroNumero);
                $('body').on('click', '.enlace_eliminar_numero_adicional', me.Eventos.EliminarNumeroAdicional);
                $('body').on('click', '.enlace_ver_password', me.Eventos.MostrarPassword);
                $('body').on('click', '.opcion_mi_perfil_titulo', me.Eventos.MostrarContenidoOpcionPerfil);
                $('body').on('click', '.enlace_abrir_mapa', me.Eventos.AbrirPopupUbicacionDireccionEntrega);
                $('body').on('click', '#CerrarPopupUbicacionDireccionEntrega', me.Eventos.CerrarPopupUbicacionDireccionEntrega);
                $('body').on('click', '#btnConfirmarUbicacionDireccionEntrega', me.Eventos.ConfirmarUbicacionDireccionEntrega);

                $('body').on('change', '#Ubigeo1,#Ubigeo2', me.Eventos.UbigeoChanged);
                //$('body').on('click', '#Ubigeo2', me.Eventos.UbigeoChanged);

            },
           
            mostrarTelefono: function () {
                if ($('#txtTelefonoTrabajoMD').val() != '') {
                    $('.enlace_agregar_num_adicional').fadeOut(150);
                    $('.label_num_adicional').fadeIn(100);
                    $('.contenedor_campos_num_adicional').fadeIn(150);
                }
            },
            PuedeActualizar: function () {
                if ($('#hdn_PuedeActualizar').val() == '0' || $('#hdn_PuedeActualizar').val() == false) {
                    $('#txtSobrenombreMD').prop('disabled', true);
                    $('#txtEMailMD').prop('disabled', true);
                    $('#txtCelularMD').prop('disabled', true);
                    $('#txtTelefonoMD').prop('disabled', true);
                    $('#txtTelefonoTrabajoMD').prop('disabled', true);
                    $('#btnCambiarCelular').bind('click', false);
                    $('#btnCambiarEmail').bind('click', false);
                    $('#btnAgregarOtroNumero').bind('click', false);
                    $('#btnGuardar').prop('disabled', true);
                }
            },
            PuedeCambiarTelefono: function () {
                var smsFlag = $('#hdn_ServicioSMS').val();
                if (smsFlag == '0' || smsFlag == false) {
                    $('#btnCambiarCelular').hide();
                } else {
                    $('#txtCelularMD').prop('readonly', true);
                }
            },
            CamposFormularioConDatos: function () {
                var camposFormulario = $('.grupo_form_cambio_datos input, .grupo_form_cambio_datos select');
                $.map(camposFormulario, function (campoFormulario, key) {
                    if ($(campoFormulario).val() != 0) {
                        $(campoFormulario).addClass('campo_con_datos');
                    }
                });
            },
            EvitandoCopiarPegar: function () {
                FuncionesGenerales.AvoidingCopyingAndPasting('txtTelefonoMD');
                FuncionesGenerales.AvoidingCopyingAndPasting('txtTelefonoTrabajoMD');
                FuncionesGenerales.AvoidingCopyingAndPasting('txtCelularMD');
                FuncionesGenerales.AvoidingCopyingAndPasting('txtContraseniaAnterior');
                FuncionesGenerales.AvoidingCopyingAndPasting('txtNuevaContrasenia01');
                FuncionesGenerales.AvoidingCopyingAndPasting('txtNuevaContrasenia02');
            },

            ValidacionSoloLetras: function () {
                $("#txtTelefonoMD").keypress(function (evt) {
                    var charCode = (evt.which) ? evt.which : (window.event ? window.event.keyCode : null);
                    if (!charCode) return false;
                    if (charCode <= 13) {
                        return false;
                    }
                    else {
                        var keyChar = String.fromCharCode(charCode);
                        var re = /[0-9+ *#-]/;
                        return re.test(keyChar);
                    }
                });
                $("#txtTelefonoTrabajoMD").keypress(function (evt) {
                    var charCode = (evt.which) ? evt.which : (window.event ? window.event.keyCode : null);
                    if (!charCode) return false;
                    if (charCode <= 13) {
                        return false;
                    }
                    else {
                        var keyChar = String.fromCharCode(charCode);
                        var re = /[0-9+ *#-]/;
                        return re.test(keyChar);
                    }
                });
                $("#txtCelularMD").keypress(function (evt) {
                    var charCode = (evt.which) ? evt.which : (window.event ? window.event.keyCode : null);
                    if (!charCode) return false;
                    if (charCode <= 13) {
                        return false;
                    }
                    else {
                        var keyChar = String.fromCharCode(charCode);
                        var re = /[0-9+ *#-]/;
                        return re.test(keyChar);
                    }
                });
            },
            ModoEdicion: function() {
                //$('#Ubigeo1').trigger("change");
                me.Funciones.CargarUbigeos();
            },
            ShowLoading: function () {
                if (me.Funciones.isMobile()) {
                    ShowLoading();
                } else {
                    waitingDialog();
                }
            },
            isMobile: function() {
                if (sessionStorage.desktop)
                    return false;
                else if (localStorage.mobile)
                    return true;
                var mobile = [
                    'iphone', 'ipad', 'android', 'blackberry', 'nokia', 'opera mini', 'windows mobile', 'windows phone',
                    'iemobile'
                ];
                for (var i =0 ; i< mobile.length ; i++)
                {
                    if (navigator.userAgent.toLowerCase().indexOf(mobile[i].toLowerCase()) > 0)
                        return true;
                }
            
        
                return false;
            },
            CloseLoading: function () {
                if (me.Funciones.isMobile()) {
                    CloseLoading();
                } else {
                    closeWaitingDialog();
                }
            },
            CargarUbigeos: function () {
                var deferreds = [];
                $.each(Ubigeos, function (i, n) {
                   var Identity = i.substring(i.length - 1);
                   var elementSiguiente = 'Ubigeo' + (parseInt(Identity) + 1);
                    if ($('#' + elementSiguiente)[0]!= undefined) {
                      var  Nivel = $('#' + i).attr('Nivel');
                      deferreds.push(me.Funciones.ConsultaUbigeo(Nivel, n, elementSiguiente));
                    }
                });
                $.when.apply(null, deferreds).done(function () {
                    debugger;
                    $.each(Ubigeos, function (i, n) {
                        debugger;
                       var Identity = i.substring(i.length - 1);
                       var elementSiguiente = 'Ubigeo' + (parseInt(Identity) + 1);
                        if ($('#' + elementSiguiente)[0] != undefined) {
                            $('#' + elementSiguiente).val(Ubigeos[elementSiguiente]);
                        }
                    });
                    
                });

            },
            ConsultaUbigeo: function (Nivel, IdPadre , IdElemento) {
                var deferredObject = $.Deferred(); 
                //me.Funciones.ShowLoading();
                AbrirLoad();
                $.ajax({
                    url: UrlDrop,
                    type: 'GET',
                    data: { Nivel: Nivel, IdPadre: IdPadre },
                    dataType: 'json',
                    success: function (response) {
                        debugger;
                       
                        var len = response.length;
                        CerrarLoad();
                        //me.Funciones.CloseLoading();
                        $('#' + IdElemento).empty();
                        $('#' + IdElemento).append("<option value>--Seleccionar</option>");
                        for (var i = 0; i < len; i++) {
                            var id = response[i]['IdParametroUnete'];
                            var name = response[i]['Nombre'];

                            $('#' + IdElemento).append("<option value='" + id + "'>" + name + "</option>");

                        }
                        deferredObject.resolve();
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CerrarLoad();
                            deferredObject.reject();
                        }
                    }
                });
                return deferredObject.promise();
            },
            ItemSelected: function (selector) {
                debugger;
                var ubigeo = $(selector).attr('id');
                if (Ubigeos[ubigeo] != 0)
                {
                    $(selector).val(Ubigeos[ubigeo]).change();
                    Ubigeos[ubigeo] = 0;
                }

            }
            
        },
        me.Eventos = {
                LabelActivo: function () {
                    var campoDatos = $(this).val();
                    if (campoDatos != 0) {
                        $(this).addClass('campo_con_datos');
                    } else {
                        $(this).removeClass('campo_con_datos');
                    }
                },
                AgregarOtroNumero: function (e) {
                    e.preventDefault();
                    $(this).fadeOut(150);
                    $('.label_num_adicional').fadeIn(100);
                    $('.contenedor_campos_num_adicional').fadeIn(150);
                },
                EliminarNumeroAdicional: function (e) {
                    e.preventDefault();
                    $('.contenedor_campos_num_adicional').fadeOut(150);
                    $('.label_num_adicional').fadeOut(100);
                    $('.enlace_agregar_num_adicional').fadeIn(150);
                    $('.contenedor_campos_num_adicional input').val('');
                },
                MostrarPassword: function (e) {
                    e.preventDefault();
                    var _this = e.target;
                    var campoPassword = $(_this).parent().find('input');
                    if (campoPassword.val() != '') {
                        if ($(_this).is('.icono_ver_password_activo')) {
                            $(_this).removeClass('icono_ver_password_activo');
                            campoPassword.attr('type', 'password');
                        } else {
                            $(_this).addClass('icono_ver_password_activo');
                            campoPassword.attr('type', 'text');
                        }
                    }
                },
                MostrarContenidoOpcionPerfil: function () {
                    $(this).next().slideToggle(200);
                    $(this).parent().toggleClass('mostrarContenido');
                    if ($(this).parent().is('.opcion_mis_datos')) {
                        if ($(this).next().is(':visible')) {
                            if ($('#txtTelefonoTrabajoMD').val() == '') {
                                $('.contenedor_campos_num_adicional').fadeOut(100);
                                $('.enlace_agregar_num_adicional').fadeIn(100);
                            }
                        }
                    }
                },
                AbrirPopupUbicacionDireccionEntrega: function () {
                    $('.fondo_popup_ubicacion_direccion_entrega').fadeIn(150);
                    $('.popup_ubicacion_direccion_entrega').fadeIn(150);
                },
                ConfirmarUbicacionDireccionEntrega: function () {
                _googleMap.Funciones.ConfirmarUbicacion();
                $('.fondo_popup_ubicacion_direccion_entrega').fadeOut(150);
                $('.popup_ubicacion_direccion_entrega').fadeOut(150);
                //me.Eventos.CerrarPopupUbicacionDireccionEntrega();
            },
                CerrarPopupUbicacionDireccionEntrega: function () {
                    
                    //me.Funciones.ResetearMapa();

                    _googleMap.Funciones.ResetearMapa();
                    $('.fondo_popup_ubicacion_direccion_entrega').fadeOut(150);
                    $('.popup_ubicacion_direccion_entrega').fadeOut(150);
                },
              
            UbigeoChanged: function () {

                debugger;
                var context = this;
                var IdName = $(context).attr('id');
                var Identity = IdName.substring(IdName.length - 1);
                var IdDependiente = '#Ubigeo' + (parseInt(Identity) + 1);
                var Nivel = $(context).attr('Nivel');
                var IdPadre = $(context).val() == "" ? "" : $(context).val();
                var optVal = $('#' + IdName + ' option:selected').val();
                var optionSelected = $("option:selected", this).attr('value');
                if ($(IdDependiente)[0] == undefined)
                    return;
                   me.Funciones.ShowLoading();

                    $.ajax({
                        url: UrlDrop,
                        type: 'GET',
                        data: { Nivel: Nivel, IdPadre: IdPadre },
                        dataType: 'json',
                        success: function (response) {
                            
                            var len = response.length;
                            me.Funciones.CloseLoading();
                            $(IdDependiente).empty();
                            $(IdDependiente).append("<option value>--Seleccionar</option>");
                            for (var i = 0; i < len; i++) {
                                var id =   response[i]['IdParametroUnete'];
                                var name = response[i]['Nombre'];
                                $(IdDependiente).append("<option value='" + id + "'>" + name + "</option>");
                            }
                            me.Funciones.ItemSelected(IdDependiente);
                            if (IdName === 'Ubigeo1')
                            {
                                _googleMap.Funciones.LimpiarMapa();
                            }
                        }
                    });

                }
            },
        me.Inicializar = function () {
                 
                me.Funciones.InicializarEventos();
                me.Funciones.CamposFormularioConDatos();
                me.Funciones.mostrarTelefono();
                me.Funciones.PuedeActualizar();
                me.Funciones.PuedeCambiarTelefono();
                me.Funciones.EvitandoCopiarPegar();
                me.Funciones.ValidacionSoloLetras();
               if ($('#Operacion').val() == OperacionDb.Editar)
                   me.Funciones.ModoEdicion();
            }
     
    }

    MiPerfil = new vistaMiPerfil();
    MiPerfil.Inicializar();

    $("#btnCambiarPass").click(function () { CambiarContrasenia(); });

    $("#btnGuardar").click(function () { actualizarDatos(); });

    $('#btnEliminarFoto').click(function () { eliminarFotoConsultora(); });

    $('#hrefTerminosMD').click(function () { EnlaceTerminosCondiciones(); });
    $('#btnConfirmarUbicacionDireccionEntrega').click(function () { EnlaceTerminosCondiciones(); });
    ConsultarActualizaEmail();
    CancelarAtualizacionEmail();
});
 




function EnlaceTerminosCondiciones() {
    var enlace = $('#hdn_enlaceTerminosCondiciones').val();
    $('#hrefTerminosMD').attr('href', enlace);
}





function actualizarDatos() {
    var hdn_CaracterMaximo = $("#hdn_CaracterMaximo").val();
    var hdn_CaracterMinimo = $("#hdn_CaracterMinimo").val();
    var hdn_iniciaNumero = $('#hdn_iniciaNumero').val();
    var txtCelularMD = jQuery.trim($('#txtCelularMD').val());
    var txtTelefonoMD = jQuery.trim($("#txtTelefonoMD").val());
    var txtTelefonoTrabajoMD = jQuery.trim($("#txtTelefonoTrabajoMD").val());
    var txtEMailMD = jQuery.trim($('#txtEMailMD').val());


    var Ubigeo1 = $('#Ubigeo1').val();
    var Ubigeo2 = $('#Ubigeo2').val();
    var Latitud = $('#Latitud').val();
    var Longitud = $('#Longitud').val();

    var Referencia = $('#Referencia').val();


    if (txtEMailMD == "") {
        alert("Debe ingresar EMail.\n");
        return false;
    }

    if (!validateEmail(txtEMailMD)) {
        alert("El formato del correo electrónico ingresado no es correcto.\n");
        return false;
    }

    if ((txtTelefonoMD == null || txtTelefonoMD == "") &&
        (txtCelularMD == null || txtCelularMD == "")) {
        alert('Debe ingresar al menos un número de contacto: celular o teléfono.');
        return false;
    }

    if (txtCelularMD != "") {
        if (!isInt(txtCelularMD)) {
            alert('El formato del celular no es correcto');
            return false;
        }
        if (isZero(txtCelularMD)) {
            alert('El formato del celular no es correcto');
            return false;
        }
        if (txtCelularMD.length != hdn_CaracterMaximo) {
            alert('El formato del celular no es correcto');
            return false;
        }
    }

    if (txtCelularMD != "") {
        if (hdn_iniciaNumero > 0) {
            if (txtCelularMD != null || txtCelularMD != "") {
                if (hdn_iniciaNumero != txtCelularMD.charAt(0)) {
                    alert('Su número de celular debe empezar con ' + hdn_iniciaNumero + '.');
                    return false;
                }
            }
        }
    }

    if (txtCelularMD != "") {
        if (!ValidarTelefono(txtCelularMD)) {
            alert('El celular que está ingresando ya se encuenta registrado.');
            return false;
        }
    }

    if (txtTelefonoMD != "") {
        if (!isInt(txtTelefonoMD)) {
            alert('El formato de teléfono no es correcto');
            return false;
        }
        if (isZero(txtTelefonoMD)) {
            alert('El formato del teléfono no es correcto');
            return false;
        }

        if (txtTelefonoMD.length < hdn_CaracterMinimo) {
            alert('El número de teléfono debe tener como mínimo ' + hdn_CaracterMinimo + ' números.');
            return false;
        }
        if (txtTelefonoMD.length > hdn_CaracterMaximo) {
            alert('El número de teléfono debe tener como máximo ' + hdn_CaracterMaximo + ' números.');
            return false;
        }
    }

    if (txtTelefonoTrabajoMD != "") {
        if (!isInt(txtTelefonoTrabajoMD)) {
            alert('El formato de número adicional no es correcto');
            return false;
        }
        if (isZero(txtTelefonoTrabajoMD)) {
            alert('El formato de número adicional no es correcto');
            return false;
        }

        if (txtTelefonoTrabajoMD.length < hdn_CaracterMinimo) {
            alert('El número adicional debe tener como mínimo ' + hdn_CaracterMinimo + ' números.');
            return false;
        }
        if (txtTelefonoTrabajoMD.length > hdn_CaracterMaximo) {
            alert('El número adicional debe tener como máximo ' + hdn_CaracterMaximo + ' números.');
            return false;
        }
    }

    if (Ubigeo1 == "") {
         var item =  $('label[for="Ubigeo1"]').html();
        alert("Debe seleccionar " + item + ".");
        return false;
    }
    if (Ubigeo2 == "") {
        var item = $('label[for="Ubigeo2"]').html();
        alert("Debe seleccionar " + item + ".");
        return false;
    }


    if (Referencia == "") {
        alert("Debe ingresar una dirección de referencia.");
        return false;
    }

    if (Latitud == 0 || Longitud == 0) {
        alert("Debe ingresar una dirección.");
        return false;
    }
    if (!$('#chkAceptoContratoMD').is(':checked')) {
        alert('Debe aceptar los términos y condiciones para poder actualizar sus datos.');
        return false;
    }

    AbrirLoad();

    debugger;
    var direccion = {

        Ubigeo1: $('#Ubigeo1').val(),
        Ubigeo2: $('#Ubigeo2').val(),
        Direccion: $('#Direccion').val(),
        Latitud: $('#Latitud').val(),
        Longitud: $('#Longitud').val(),
        Operacion: $('#Operacion').val()

    }

    var item = {
        CodigoUsuario: jQuery('#hdn_CodigoUsuarioReal').val(),
        EMail: $.trim(jQuery('#txtEMailMD').val()),
        Telefono: jQuery('#txtTelefonoMD').val(),
        TelefonoTrabajo: jQuery('#txtTelefonoTrabajoMD').val(),
        Celular: jQuery('#txtCelularMD').val(),
        Sobrenombre: jQuery('#txtSobrenombreMD').val(),
        CorreoAnterior: $.trim(jQuery('#hdn_CorreoMD').val()),
        NombreCompleto: jQuery('#hdn_NombreCompletoMD').val(),
        CompartirDatos: false,
        AceptoContrato: $('#chkAceptoContratoMD').is(':checked'),
        DireccionEntrega: direccion
    };

    
    jQuery.ajax({
        type: 'POST',
        //url: baseUrl + 'MiPerfil/ActualizarDatos',
        url: baseUrl + 'MiPerfil/RegistrarPerfil',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                CerrarLoad();
                alert(data.message);
                window.location = $('#volverBienvenida').attr('href');
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarLoad();
                alert("ERROR");
            }
        }
    });
}

function ValidarTelefono(celular) {
    var resultado = false;

    var item = {
        Telefono: celular
    };

    AbrirLoad();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/ValidadTelefonoConsultora',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                resultado = false;
            else
                resultado = data.success;
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });

    return resultado;
}

function limitarMinimo(contenido, caracteres, a) {
    if (contenido.length < caracteres && contenido.trim() != "") {
        var texto = a == 1 ? "teléfono" : a == 2 ? "celular" : "otro teléfono";
        alert('El número de ' + texto + ' debe tener como mínimo ' + caracteres + ' números.');
        return false;
    }
    return true;
}

function CambiarContrasenia() {
    var oldPassword = $("#txtContraseniaAnterior").val();
    var newPassword01 = $("#txtNuevaContrasenia01").val();
    var newPassword02 = $("#txtNuevaContrasenia02").val();
    var vMessage = "";

    if (oldPassword == "")
        vMessage += "- Debe ingresar la Contraseña Anterior.\n";

    if (newPassword01 == "")
        vMessage += "- Debe ingresar la Nueva Contraseña.\n";

    if (newPassword02 == "")
        vMessage += "- Debe repetir la Nueva Contraseña.\n";

    if (newPassword01.length <= 6)
        vMessage += "- La Nueva Contraseña debe de tener más de 6 caracteres.\n";

    if (newPassword01 != "" && newPassword02 != "") {
        if (newPassword01 != newPassword02)
            vMessage += "- Los campos de la nueva contraseña deben ser iguales, verifique.\n";
    }

    if (oldPassword != "" && newPassword01 != "" && newPassword02 != "") {
        if (newPassword01 == oldPassword || newPassword02 == oldPassword) {
            vMessage += "- La Nueva Contraseña no debe ser igual a la actual.\n";
        }
    }

    if (vMessage != "") {
        alert(vMessage);
        return false;
    } else {
        AbrirLoad();
        var item = {
            OldPassword: oldPassword,
            NewPassword: newPassword01
        };

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'MiPerfil/CambiarConsultoraPass',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    CerrarLoad();
                    if (data.success == true) {
                        if (data.message == "0") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("La contraseña anterior ingresada es inválida");
                        } else if (data.message == "1") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("Hubo un error al intentar cambiar la contraseña, por favor intente nuevamente.");
                        } else if (data.message == "2") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');

                            $("#contentPass").fadeOut(200);
                            $("#contentPassChange").delay(200);
                            $("#contentPassChange").fadeIn(200);
                        }
                        return false;
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    CerrarLoad();
                    alert("Error en el Cambio de Contraseña");
                }
            }
        });
    }
}

function eliminarFotoConsultora() {
    var item = {}
    AbrirLoad();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MiPerfil/EliminarFoto',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            if (checkTimeout(data)) {
                CerrarLoad();
                alert(data.message);
                window.location = $('#volverBienvenida').attr('href');
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarLoad();
                alert("ERROR");
            }
        }
    });
}

function SubirImagen(url, image) {
    var item = {
        nameImage: image
    }

    AbrirLoad();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MiPerfil/SubirImagen',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            if (data.success) {
                CerrarLoad();
                alert('Su foto de perfil se cambio correctamente.');
                window.location = url;
            } else {
                alert('Hubo un error al cargar el archivo, intente nuevamente.');
                CerrarLoad();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarLoad();
                alert("ERROR");
            }
        }
    });
}

function ConsultarActualizaEmail() {
    var elementA = document.getElementById('hrefNocambiarCorreo');
    var item = {
        pagina: "2"
    }

    if (elementA) {
        $.ajax({
            type: 'POST',
            url: baseUrl + 'Bienvenida/ObtenerActualizacionEmailSms',
            dataType: 'Text',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            success: function (data) {
                if (checkTimeout(data)) {
                    if (data != "") {
                        if (data.split('|')[1] != ""){
                            document.getElementsByClassName('toolTipCorreo')[0].style.display = 'block';
                            document.getElementById('EmailNuevo').innerHTML = data.split('|')[1];
                        }
                        if (data.split('|')[0] != "") {
                            document.getElementsByClassName('toolTipCelular')[0].style.display = 'block';
                            document.getElementById('CelularNuevo').innerHTML = data.split('|')[0];
                        }
                    }
                }
            },
            error: function (data, error) {
                alert(error);
            }
        });
    }
}

function CancelarAtualizacionEmail() {
    var elementA = document.getElementById('hrefNocambiarCorreo');
    var elementB = document.getElementById('hrefNocambiarCelular');

    if (elementA) {
        elementA.onclick = function (e) {
            e.preventDefault();
            CancelarActualizarEmailySMS('Email');
        }
    }

    if (elementB) {
        elementB.onclick = function (event) {
            event.preventDefault();
            CancelarActualizarEmailySMS('SMS');
        }
    }
}

function CancelarActualizarEmailySMS(tipoEnvio) {
    var item = {
        tipoEnvio: tipoEnvio
    }
    $.ajax({
        type: 'POST',
        url: baseUrl + 'MiPerfil/CancelarAtualizacionEmail',
        dataType: 'Text',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        success: function (data) {
            if (checkTimeout(data)) {
                if (data == '1') {
                    if (tipoEnvio == 'Email')
                        document.getElementsByClassName('toolTipCorreo')[0].style.display = 'None';
                    if (tipoEnvio == 'SMS')
                        document.getElementsByClassName('toolTipCelular')[0].style.display = 'None';
                }
            }
        },
        error: function (data, error) {

        }
    });
}

var GoogleMap = function() {
    var me = this;
    me.Propiedades = {
        latitudIni: 0,
        longitudIni: 0,
        latitudFin: 0,
        longitudFin: 0,
        directionText: '',
        viewport: null
    };
    me.Funciones = {
        CrearComponentesMapa: function() {
            
            map = new google.maps.Map($('.mapa_wrapper')[0],
                {
                    center: { lat: -77.0282400, lng: -12.0431800 },
                    zoom: 17,
                    mapTypeId: 'roadmap'
                });


            marker = new google.maps.Marker({
                map: map,
                anchor: new google.maps.Point(17, 34),
                draggable: true,
                animation: google.maps.Animation.DROP

            });
            directionsService = new google.maps.DirectionsService;
            var input = document.getElementById('Direccion');


            //var options = {
            //    //types: ['(cities)'],
            //    componentRestrictions: { country: LocationCountry, postalCode: '1530000' }
            //};
            searchBox = new google.maps.places.Autocomplete(input);
            //searchBox = new google.maps.places.Autocomplete(input);
            //searchBox.setComponentRestrictions({ 'country': 'PE' });
            searchBox.setComponentRestrictions({ 'country': LocationCountry});
            searchBox.bindTo('bounds', map);
        },
        ResetearMapa: function() {
            var coordenadas = {
                lat: me.Propiedades.latitudIni,
                lng: me.Propiedades.longitudIni
            };
            
            if (me.Propiedades.viewport)
                map.fitBounds(me.Propiedades.viewport);
            map.setCenter(coordenadas);
            marker.setPosition(coordenadas);
            map.setZoom(ZoonMapa);
            $("#RouteDirection").html(me.Propiedades.directionText);
            $('#Latitud').val(me.Propiedades.latitudIni);
            $('#Longitud').val(me.Propiedades.longitudIni);

        },
        InicializarEventosMapa: function() {
            
            marker.addListener('dragstart', me.Eventos.DragStart);
            marker.addListener('dragend', me.Eventos.DragEnd);
            searchBox.addListener('place_changed', me.Eventos.PlaceChanged);

        },
        ValidacionMapa: function() {
            $('#Direccion').focusout(function() {
                if ($(this).val().length === 0 && EsMobile == 'True')
                {
                    //if (EsMobile == 'True')
                       $('.enlace_abrir_mapa')[0].disabled = true;
                }
                var dropdown = document.getElementsByClassName('pac-container')[0];
                if (dropdown.style.display == 'none') {
                    me.Funciones.LimpiarMapa();
                }
            });

        },
        ToggleBounce: function() {

            if (marker.getAnimation() !== null) {
                marker.setAnimation(null);
            } else {
                marker.setAnimation(google.maps.Animation.BOUNCE);
            }
        },
        QueryGeocode: function(Params, Callback) {
            var geocoder = new google.maps.Geocoder;
            geocoder.geocode(Params,
                function(results, status) {
                    Callback(results, status);

                });
        },
        LimpiarMapa: function() {
            var coordenadas = {
                lat:0,
                lng:0
            }
            marker.setPosition(coordenadas);
            map.setCenter(coordenadas);
            marker.setVisible(false);
            $('#Latitud').val("0");
            $('#Longitud').val("0");
            //$('#Direccion').val('');
        },
        ConfirmarUbicacion: function () {
            
            var coordenadas = {
                lat: me.Propiedades.latitudFin,
                lng: me.Propiedades.longitudFin
            }
            marker.setPosition(coordenadas);
            map.setCenter(coordenadas);
            $('#Direccion').val(me.Propiedades.directionText);
            $('#Latitud').val(coordenadas.latitudFin);
            $('#Longitud').val(coordenadas.longitudFin);
        },
        ModoEdicion: function() {
            
            var coordenadas = {
                lat: parseFloat($('#Latitud').val()), //$('#Latitud').val()
                lng: parseFloat($('#Longitud').val())
            };
            debugger;
            me.Propiedades.latitudIni = coordenadas.lat; //$('#Latitud').val()
            me.Propiedades.longitudIni = coordenadas.lng;
            map.setCenter(coordenadas);
            marker.setPosition(coordenadas);
            map.setZoom(ZoonMapa);

        }

    };
    me.Eventos = {
        PlaceChanged: function() {
            debugger;
            var place = searchBox.getPlace();
            if (!place.geometry) {
                return;
            }
            if (place.geometry.viewport) {
                map.fitBounds(place.geometry.viewport);
                map.setCenter(place.geometry.location);
                map.setZoom(ZoonMapa);
                me.Propiedades.viewport = place.geometry.viewport;
            } else {
                map.setCenter(place.geometry.location);
                map.setZoom(ZoonMapa);
            }
            if (EsMobile == 'True')
                $('.enlace_abrir_mapa')[0].disabled = false;
            else {
                $('#Latitud').val(place.geometry.location.lat());
                $('#Longitud').val(place.geometry.location.lng());
            }
            me.Propiedades.latitudIni = place.geometry.location.lat();
            me.Propiedades.longitudIni = place.geometry.location.lng();
            marker.setPosition(place.geometry.location);
            marker.setVisible(true);
            var address = '';
            if (place.address_components) {
                address = [
                    (place.address_components[0] && place.address_components[0].short_name || ''),
                    (place.address_components[1] && place.address_components[1].short_name || ''),
                    (place.address_components[2] && place.address_components[2].short_name || '')
                ].join(' ');
                me.Propiedades.directionText = place.formatted_address;
                $("#RouteDirection").html(place.formatted_address);
            }
        },
        DragStart: function() {

            //me.Propiedades.latitudIni = this.position.lat();
            //me.Propiedades.longitudIni = this.position.lng();
        },
        DragEnd: function() {
            var Latlng = { lat: this.position.lat(), lng: this.position.lng() };
            me.Funciones.QueryGeocode({ latLng: Latlng },
                function(results, status) {
                    
                    if (status === 'OK') {
                        if (results[0]) {
                            me.Propiedades.latitudFin = Latlng.lat;
                            me.Propiedades.longitudFin = Latlng.lng;
                            for (var i = 0; i < results.length; i++) {
                                if (results[i].types.indexOf('street_address') >= 0) {
                                    
                                    if(EsMobile=='True')
                                        $("#RouteDirection").html(results[i].formatted_address);
                                    else
                                        $("#Direccion").val(results[i].formatted_address);

                                    me.Propiedades.directionText = results[i].formatted_address;

                                    break;
                                }
                            }
                 
                        } else {
                            window.alert('No results found');
                            return false;
                        }
                    } else {
                        window.alert('Geocoder failed due to: ' + status);
                        return false;
                    }
                });
        },
        BoundsChanged: function() {
            searchBox.setBounds(map.getBounds());
        }
    };
    me.InicializarMapa = function () {
        me.Funciones.CrearComponentesMapa();
        me.Funciones.InicializarEventosMapa();
        me.Funciones.ValidacionMapa();
        
        if ($('#Operacion').val() == OperacionDb.Editar)
           me.Funciones.ModoEdicion();
    }

}

function initMapa() {
    
        _googleMap = new GoogleMap();
        _googleMap.InicializarMapa();
   
}