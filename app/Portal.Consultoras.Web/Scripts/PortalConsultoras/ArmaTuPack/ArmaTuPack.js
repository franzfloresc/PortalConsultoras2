
//// todo movido a fichaModule.js
//function AbrirPopupArmaTuPack(campaniaId, setid, cuv) {
//    AbrirLoad();
//    var params =
//        {
//            campaniaId: campaniaId,
//            set: setid,
//            cuv: cuv
//        };

//    jQuery.ajax({
//        type: "POST",
//        url: '/Pedido/ObtenerOfertaByCUVSet',
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify(params),
//        async: true,
//        success: function (data) {
//            if (checkTimeout(data)) {
//                if (data.success) {
//                    if (data.pedidoSet) {
//                        if (data.pedidoSet.Detalles) {
//                            var strComponentes = '<ul>';

//                            $(data.pedidoSet.Detalles).each(function (i, v) {

//                                strComponentes = strComponentes + '<li style="list-style:none;text-align:left">- ' + v.NombreProducto + '</li>';
//                            });

//                            strComponentes = strComponentes + '</ul>';

//                            CerrarLoad();
                        
//                            AbrirMensaje(strComponentes, "El pack que armaste contiene:");
//                            bindBlackScreenToCloseButton();
//                        }
//                    }
//                }
//                else CerrarLoad();
//            }
//            else {
//                CerrarLoad();
//                messageInfoError(data.message);
//            }
//        },
//        error: function (data, error) {
//            CerrarLoad();
//            if (checkTimeout(data)) {
//                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
//            }
//        }
//    });
//}

//function bindBlackScreenToCloseButton() {

//    $('.ui-widget-overlay').click(function () {
//        $('.ui-dialog-titlebar-close').click();
//    });
//}