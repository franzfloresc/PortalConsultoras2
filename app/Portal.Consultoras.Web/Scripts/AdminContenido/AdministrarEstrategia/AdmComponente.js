var AdmComponente = (function () {

    var _url = {
        ConsultarSegunEstrategia: "/AdministrarComponente/ConsultarSegunEstrategia",
        urlInsertOfertaShowRoomDetalle: '/AdministrarComponente/InsertOfertaShowRoomDetalleNew',
        urlUpdateOfertaShowRoomDetalle: '/AdministrarComponente/UpdateOfertaShowRoomDetalleNew',
        urlEliminarOfertaShowRoomDetalle: 'AdministrarComponente/EliminarOfertaShowRoomDetalleNew',
        urlEliminarOfertaShowRoomDetalleAll: '/AdministrarShowRoom/EliminarOfertaShowRoomDetalleAllNew'
    };

    var _codigoEstrategia = ConstantesModule.ConstantesPalanca;

    var _eventos = {
        clickNuevoDetalle: function () {
            _limpiarDatosEventoShowRoomDetalle();

            $("#txtCUVProductoDetalle").attr("readonly", false);
            $("#txtPrecioOfertaDetalle").attr("readonly", false);

            showDialog("DialogRegistroOfertaShowRoomDetalleEditar");
        }
    }

    var _limpiarDatosEventoShowRoomDetalle = function () {
        $("#hdEstrategiaProductoID").val("0");
        $("#txtCUVProductoDetalle").val("");
        $("#txtNombreProductoDetalle").val("");
        $("#txtDescripcion1Detalle").val("");

        $("#txtPrecioOfertaDetalle").val("0");
        $("#chkActivoOfertaDetalle").attr("checked", false);

        $("#ddlMarcaProductoDetalle").val("0");
        $("#imgProductoDetalle").attr("src", admConfig.Config.imagenProductoVacio);
        $("#hdImagenDetalle").val("");
        $("#hdImagenDetalleAnterior").val("");
    }

    var _limpiarDatos = function () {
        $("#chkActivoOfertaDetalle").removeAttr("checked");
        //$("#chkEsSubCampania").removeAttr("checked");
    }

    var _registrarOfertaShowRoomDetalle = function () {
        var accion;

        if ($("#hdEstrategiaProductoID").val() == "0")
            accion = _url.urlInsertOfertaShowRoomDetalle;
        else
            accion = _url.urlUpdateOfertaShowRoomDetalle;

        var isActive = ($("#chkActivoOfertaDetalle").val()) ? "1" : "0";

        var item = {
            EstrategiaProductoID: $("#hdEstrategiaProductoID").val(),
            EstrategiaID: $("#hdEstrategiaID").val(),
            Campania: $("#txtCampaniaDetalle").val(),
            CUV2: $("#txtCUVDetalle").val(),
            CUV: $("#txtCUVProductoDetalle").val(),
            Precio: $("#txtPrecioOfertaDetalle").val(),
            NombreProducto: $("#txtNombreProductoDetalle").val(),
            Descripcion1: $("#txtDescripcion1Detalle").val(),
            IdMarca: $("#ddlMarcaProductoDetalle").val(),
            Activo: isActive,
            ImagenProducto: $("#hdImagenDetalle").val(),
            ImagenAnterior: $("#hdImagenDetalleAnterior").val()
        };

        waitingDialog({ title: "Procesando" });
        jQuery.ajax({
            type: "POST",
            url: accion,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    if (data.success == true) {
                        alert(data.message);
                        HideDialog("DialogRegistroOfertaShowRoomDetalleEditar");
                        _limpiarDatos();
                        jQuery("#listShowRoomDetalle").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
                    }
                    else {
                        alert(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert(data.message);
                    HideDialog("DialogRegistroOfertaShowRoomDetalleEditar");
                }
            }
        });
    }

    var _limpiarDatosShowRoomDetalle = function () {
        $("#txtPaisDetalle").val("");
        $("#txtCampaniaDetalle").val("");
        $("#txtCUVDetalle").val("");
        $("#txtDescripcionDetalle").val("");
        $("#txtPrecioValorizadoDetalle").val("");
    }


    var _showImageDetalle = function (cellvalue, options, rowObject) {
        var image = "";
        if (rowObject[6] != "") {
            image = '<img src="' + rowObject[6] + '" alt="" width="70px" height="60px" title="" border="0" />';
        } else {
            image = '<img src="' + admConfig.Config.imagenProductoVacio + '" alt="" width="60px" height="60px" title="" border="0" />';
        }
        return image;
    }

    var _showActionsDetalle = function (cellvalue, options, rowObject) {
        var id = rowObject[0];
        var estrategiaId = rowObject[1];
        var cuv = rowObject[3];
        var imagen = rowObject[6];

        var edit = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listShowRoomDetalle').EditarProductoDetalle('" + id + "','" + imagen + "');\" >"
            + "<img src='" + admConfig.Config.rutaImagenEdit + "' alt='Editar Producto' title='Editar Producto' border='0' /></a>";
        var remove = "";

        if (rowObject[10] == "1") {
            remove = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listShowRoomDetalle').EliminarProductoDetalle('" + id + "','" + estrategiaId + "','" + cuv + "');\" >"
                + "<img src='" + admConfig.Config.rutaImagenDisable + "' alt='Deshabilitar Producto' title='Deshabilitar Producto' border='0' /></a>";
        }

        return edit + remove;
    }

    var fnGrillaOfertaShowRoomDetalle = function (campaniaId, cuv, estrategiaId) {

        $("#listShowRoomDetalle").jqGrid("clearGridData");

        var parametros = {
            estrategiaId: estrategiaId,
            codigoTipoEstrategia: $("#ddlTipoEstrategia").find(":selected").data("codigo")
        };

        $("#listShowRoomDetalle").setGridParam({ postData: parametros });
        $("#hdEstrategiaID").val(estrategiaId);

        jQuery("#listShowRoomDetalle").jqGrid({
            url: _url.ConsultarSegunEstrategia,
            hidegrid: false,
            datatype: "json",
            postData: (parametros),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["EstrategiaProductoId", "EstrategiaId", "CampaniaID", "CUV", "Nombre", "Descripcion Catalogo", "Foto", "Marca", "", "", "", "Acciones"],
            colModel: [
                { name: "EstrategiaProductoId", index: "EstrategiaProductoId", width: 50, editable: true, resizable: false, hidden: true },
                { name: "EstrategiaId", index: "Estrategia", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Campania", index: "Campania", width: 50, editable: true, resizable: false, hidden: true },
                { name: "CUV", index: "CUV", width: 50, editable: true, resizable: false, hidden: false },
                { name: "NombreProducto", index: "NombreProducto", width: 80, editable: true, resizable: false },
                { name: "NombreComercial", index: "NombreComercial", width: 80, editable: true, resizable: false },
                //{ name: "Descripcion1", index: "Descripcion1", width: 80, editable: true, resizable: false },
                { name: "ImagenProducto", index: "ImagenProducto", width: 60, editable: true, resizable: false, sortable: false, align: "center", formatter: _showImageDetalle },
                { name: "IdMarca", index: "IdMarca", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Precio", index: "Precio", width: 50, editable: true, resizable: false, hidden: true },
                { name: "PrecioValorizado", index: "PrecioValorizado", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Activo", index: "Activo", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Options", index: "Options", width: 40, editable: true, sortable: false, align: "center", resizable: false, formatter: _showActionsDetalle }
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: true,
                cell: "cell",
                id: "id"
            },
            pager: jQuery("#pagerShowRoomDetalle"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Nombre",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 840,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function () {
            },
            gridComplete: function () {
            }
        });
        jQuery("#listShowRoomDetalle").jqGrid("navGrid", "#pagerShowRoomDetalle", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listShowRoomDetalle").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }


    function editarProducto(ID, CampaniaID, CUV, event) {

        if (event) {
            event.preventDefault();
            event.stopPropagation();
        }

        _limpiarDatosShowRoomDetalle();

        $("#txtPaisDetalle").val(admConfig.Variable.paisNombre);
        $("#txtCampaniaDetalle").val(CampaniaID);
        $("#txtCUVDetalle").val(CUV);
        $("#txtDescripcionDetalle").val(jQuery("#list").jqGrid("getCell", ID, "DescripcionCUV2"));
        $("#txtPrecioValorizadoDetalle").val(jQuery("#list").jqGrid("getCell", ID, "Precio2"));

        /*INI ATP*/
        $("#hdEstrategiaIDMongo").val(ID);
        var newTitulo = $("#ddlTipoEstrategia").find(":selected").data("codigo") == _codigoEstrategia.ArmaTuPack ? "Edición de grupos" : "Edición de Productos"
        $('#DialogRegistroOfertaShowRoomDetalle').dialog('option', 'title', newTitulo);
        /*END ATP*/

        showDialog("DialogRegistroOfertaShowRoomDetalle");

        // obtener de AdmComponente
        admComponente.FnGrillaOfertaShowRoomDetalle(CampaniaID, CUV, ID);
        return false;
    }

    function eliminarProducto(EstrategiaID, event) {
        if (event) {
            event.preventDefault();
            event.stopPropagation();
        }

        var eliminar = confirm("¿ Está seguro que desea deshabilitar todos los productos del set ?");
        if (!eliminar)
            return false;

        var item = {
            estrategiaID: EstrategiaID
        };

        waitingDialog();
        jQuery.ajax({
            type: "POST",
            url: _url.urlEliminarOfertaShowRoomDetalleAll,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();

                    if (data.success == true) {
                        alert(data.message);
                    } else
                        alert(data.message);
                }

                return false;
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("ERROR");
                }
            }
        });
        return false;
    }

    function editarProductoDetalle(ID, Imagen) {
        $("#hdEstrategiaProductoID").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "EstrategiaProductoId"));
        $("#hdEstrategiaID").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "EstrategiaId"));
        $("#txtCUVProductoDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "CUV"));
        $("#txtNombreProductoDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "NombreProducto"));
        $("#txtDescripcion1Detalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "Descripcion1"));
        $("#txtPrecioOfertaDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "Precio"));
        $("#ddlMarcaProductoDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "IdMarca"));

        var isActive = (jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "Activo") == "1");
        $("#chkActivoOfertaDetalle").attr("checked", isActive);

        $("#txtCUVProductoDetalle").attr("readonly", true);
        $("#txtPrecioOfertaDetalle").attr("readonly", true);

        if (typeof Imagen !== "undefined") {
            var imagen = Imagen.replace(/^.*[\\\/]/, "");

            if (imagen != "prod_grilla_vacio.png") {
                $("#hdImagenDetalle").val(imagen);
                $("#hdImagenDetalleAnterior").val(imagen);
                $("#imgProductoDetalle").attr("src", Imagen);
            } else {
                $("#hdImagenDetalle").val("");
                $("#hdImagenDetalleAnterior").val("");
                $("#imgProductoDetalle").attr("src", admConfig.Config.imagenProductoVacio);
            }
        }
        else {
            $("#hdImagenDetalle").val("");
            $("#hdImagenDetalleAnterior").val("");
            $("#imgProductoDetalle").attr("src", admConfig.Config.imagenProductoVacio);
        }

        /*INI ATP*/
        //Descriptivos por default
        var newTitulo = "Registro / Edición de Productoss";
        var newLabel0 = "Descripcion1:";
        var newLabel1 = "Marca Producto:";
        var newLabel2 = '¿Activar Oferta?:';

        if ($("#ddlTipoEstrategia").find(":selected").data("codigo") == _codigoEstrategia.ArmaTuPack) {
            //Descriptivo para Grupos ATP
            newTitulo = "Edición de grupos";
            newLabel0 = "Nombre de Grupos:";
            newLabel1 = ' ';
            newLabel2 = ' ';
            $('#divMarcaProductoValue').hide();
            $('#divActivoOfertaValue').hide();
            $('.input_search').hide();//botón examinar            
        }

        $('#DialogRegistroOfertaShowRoomDetalleEditar').dialog('option', 'title', newTitulo);
        $('#spDescripcion1').html(newLabel0);
        $('#spMarcaProducto').html(newLabel1);
        $('#spActivarOferta').html(newLabel2);

        /*INI ATP*/

        showDialog("DialogRegistroOfertaShowRoomDetalleEditar");
    }

    function eliminarProductoDetalle(ID, EstrategiaID, CUV) {
        var eliminar = confirm("¿ Está seguro que desea deshabilitar el producto ?");
        if (!eliminar)
            return false;

        var item = {
            estrategiaId: EstrategiaID,
            cuv: CUV
        };

        waitingDialog();
        jQuery.ajax({
            type: "POST",
            url: _url.urlEliminarOfertaShowRoomDetalle,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();

                    if (data.success == true) {
                        alert(data.message);
                        jQuery("#listShowRoomDetalle").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
                    } else
                        alert(data.message);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("ERROR");
                }
            }
        });
    }


    var _iniDialog = function () {
        $("#DialogRegistroOfertaShowRoomDetalle").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 900,
            draggable: true,
            title: "Edición de Productos"
        });

        $("#DialogRegistroOfertaShowRoomDetalleEditar").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 800,
            draggable: true,
            title: "Registro / Edición de Productos",
            buttons:
            {
                "Guardar": function () {
                    var vMessage = "";
                    if (jQuery.trim($("#txtCUVProductoDetalle").val()) == "")
                        vMessage += "- Debe ingresar el CUV del Producto.\n";

                    if (jQuery.trim($("#ddlMarcaProductoDetalle").val()) == "0")
                        vMessage += "- Seleccione una marca del Producto.\n";

                    if (jQuery.trim($("#txtNombreProductoDetalle").val()) == "")
                        vMessage += "- Debe ingresar la el nombre del Producto.\n";

                    if (vMessage != "") {
                        alert(vMessage);
                        return false;
                    }
                    else {
                        _registrarOfertaShowRoomDetalle();
                    }
                    return false;
                },
                "Cancelar": function () {
                    HideDialog("DialogRegistroOfertaShowRoomDetalleEditar");
                }
            }
        });
    }

    var _bindingEvents = function () {
        $("body").on("click", "#btnNuevoDetalle", _eventos.clickNuevoDetalle);
    }

    function Inicializar() {
        _iniDialog();
        _bindingEvents();

    }

    return {
        Inicializar: Inicializar,
        FnGrillaOfertaShowRoomDetalle: fnGrillaOfertaShowRoomDetalle,
        EditarProducto: editarProducto,
        EliminarProducto: eliminarProducto,
        EditarProductoDetalle: editarProductoDetalle,
        EliminarProductoDetalle: eliminarProductoDetalle
    }
});