var MiPerfil;

$(document).ready(function () {

    var vistaMiPerfil;

    vistaMiPerfil = function () {
        var me = this;

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
            initAutoComplete: function () {
                //debugger;
                var map = new google.maps.Map($('.mapa_wrapper')[0], {
                    center: { lat: -33.8688, lng: 151.2195 },
                    zoom: 17,
                    mapTypeId: 'roadmap'
                });

                // Create the search box and link it to the UI element.
                var input = document.getElementById('txtDireccion');
                var searchBox = new google.maps.places.SearchBox(input);
                //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

                // Bias the SearchBox results towards current map's viewport.
                map.addListener('bounds_changed', function () {
                    //debugger;
                    searchBox.setBounds(map.getBounds());
                });

                var markers = [];
                // Listen for the event fired when the user selects a prediction and retrieve
                // more details for that place.
                searchBox.addListener('places_changed', function () {
                    //debugger;
                    var places = searchBox.getPlaces();

                    if (places.length == 0) {
                        return;
                    }

                    // Clear out the old markers.
                    markers.forEach(function (marker) {
                        marker.setMap(null);
                    });
                    markers = [];

                    // For each place, get the icon, name and location.
                    var bounds = new google.maps.LatLngBounds();
                    places.forEach(function (place) {
                        //debugger;
                        if (!place.geometry) {
                            console.log("Returned place contains no geometry");
                            return;
                        }
                        var icon = {
                            url: place.icon,
                            size: new google.maps.Size(71, 71),
                            origin: new google.maps.Point(0, 0),
                            anchor: new google.maps.Point(17, 34),
                            scaledSize: new google.maps.Size(25, 25)
                        };

                        // Create a marker for each place.
                        markers.push(new google.maps.Marker({
                            map: map,
                            icon: icon,
                            title: place.name,
                            position: place.geometry.location
                        }));

                        if (place.geometry.viewport) {
                            // Only geocodes have viewport.
                            bounds.union(place.geometry.viewport);
                        } else {
                            bounds.extend(place.geometry.location);
                        }
                    });
                    map.fitBounds(bounds);
                    map.setZoom(17);
                });
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
                    me.Eventos.CerrarPopupUbicacionDireccionEntrega();
                },
                CerrarPopupUbicacionDireccionEntrega: function () {
                    $('.fondo_popup_ubicacion_direccion_entrega').fadeOut(150);
                    $('.popup_ubicacion_direccion_entrega').fadeOut(150);
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
                google.maps.event.addDomListener(window, 'load', me.Funciones.initAutoComplete);
            }
    }

    MiPerfil = new vistaMiPerfil();
    MiPerfil.Inicializar();

    $("#btnCambiarPass").click(function () { CambiarContrasenia(); });

    $("#btnGuardar").click(function () { actualizarDatos(); });

    $('#btnEliminarFoto').click(function () { eliminarFotoConsultora(); });

    $('#hrefTerminosMD').click(function () { EnlaceTerminosCondiciones(); });

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

    if (!$('#chkAceptoContratoMD').is(':checked')) {
        alert('Debe aceptar los términos y condiciones para poder actualizar sus datos.');
        return false;
    }

    AbrirLoad();

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
        AceptoContrato: $('#chkAceptoContratoMD').is(':checked')
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MiPerfil/ActualizarDatos',
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
