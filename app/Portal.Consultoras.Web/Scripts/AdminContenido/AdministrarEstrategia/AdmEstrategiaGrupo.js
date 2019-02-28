var AdmEstrategiaGrupo = (function () {
    var _url = {
        ConsultarDetalleEstrategiaGrupo: "/EstrategiaGrupo/ConsultarDetalleEstrategiaGrupo",
        EstrategiaGrupoGuardar: "/EstrategiaGrupo/Guardar"
    };

    var _EstrategiaGrupoData = [];
    var _Valida1raCarga = false;

    var _ocultarDialogGrupo = function () {
        HideDialog("DialogGrupoEstrategia");
    };

    function ObtenerEstrategiaGrupo() {
        var mydata = [];

        jQuery.ajax({
            type: "POST",
            url: _url.ConsultarDetalleEstrategiaGrupo,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ EstrategiaId: $("#hdEstrategiaIDMongo").val() }),
            async: false,
            success: function (data) {

                mydata = data;
                console.log('grupos: ', data);

                closeWaitingDialog();

            },
            error: function (data, error) {
                closeWaitingDialog();
            }
        });

        return mydata;
    }

    function AbrirGrupoEstrategia() {

        showDialog('DialogGrupoEstrategia');
        //waitingDialog();

        _EstrategiaGrupoData = ObtenerEstrategiaGrupo();

        //$("#listGrupoEstrategia").jqGrid("clearGridData");

        if (!_Valida1raCarga) {
            _Valida1raCarga = true;

            $("#listGrupoEstrategia").jqGrid({
                data: _EstrategiaGrupoData,

                datatype: "local",
                colNames: ["EstrategiaId", "EstrategiaGrupoId", "Nro. grupo", "Nombre (Singular)", "Nombre (Plural)"],
                colModel:
                    [
                        { name: 'EstrategiaId', index: 'EstrategiaId', editable: true, hidden: true },
                        { name: 'EstrategiaGrupoId', index: 'EstrategiaGrupoId', editable: true, hidden: true },
                        { name: 'Grupo', index: 'Grupo', editable: false, width: 200 },
                        { name: 'DescripcionSingular', index: 'DescripcionSingular', editable: true, width: 250 },
                        { name: 'DescripcionPlural', index: 'DescripcionPlural', editable: true, width: 250 }
                    ],
                pager: '#pagerGrupoEstrategia',
                cellEdit: true,
                cellsubmit: 'clientArray',
                editurl: 'clientArray',
                viewrecords: true,

                sortname: "Grupo",
                sortorder: "asc",

                rowList: [10, 20, 30, 40, 50],
                rowNum: 10,
                height: "auto",
                width: 770,
                pgtext: "Pág: {0} de {1}",
                loadtext: "Cargando datos...",
                recordtext: "{0} - {1} de {2} Registros",
                emptyrecords: "No hay resultados",


                afterSaveCell: function (rowid, name, val, iRow, iCol) {

                    //console.log(rowid, name, val, iRow, iCol);
                    if (name == 'DescripcionSingular') {
                        _EstrategiaGrupoData[rowid - 1].DescripcionSingular = val;
                    }
                    if (name == 'DescripcionPlural') {
                        _EstrategiaGrupoData[rowid - 1].DescripcionPlural = val;
                    }
                    console.log(_EstrategiaGrupoData);
                }
            });
        } else {

            $("#listGrupoEstrategia").setGridParam({ data: _EstrategiaGrupoData }).trigger("reloadGrid", [{ page: 1 }]);
        }
    }


    function GuardarEstrategiaGrupo() {
        var mydata = [];

        jQuery.ajax({
            type: "POST",
            url: _url.EstrategiaGrupoGuardar,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ datos: _EstrategiaGrupoData }),
            async: false,
            success: function (data) {

                mydata = data;
                console.log('guardar result: ', data);

                if (data.estado) {
                    showDialogMensaje("Información guardada satisfactoriamente.");

                    //Obtener componentes
                    admComponente.FnGrillaOfertaShowRoomDetalle($("#txtCampaniaDetalle").val(), $("#txtCUVDetalle").val(), $("#hdEstrategiaIDMongo").val());
                } else {
                    showDialogMensaje("La operación cancelada. Ocurró un error interno.");

                }
                _ocultarDialogGrupo();
                closeWaitingDialog();

            },
            error: function (data, error) {
                closeWaitingDialog();

            }
        });

        return mydata;
    }
    var _iniDialog = function () {

        $("#DialogGrupoEstrategia").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 830,
            draggable: false,
            title: "Configurar grupo de estrategia",
            close: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).show(); },
            open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
            buttons:
            {
                "Guardar": function () {
                    GuardarEstrategiaGrupo();
                },
                "Salir": function () {
                    _ocultarDialogGrupo();
                }
            }
        });
    }

    var _bindingEvents = function () {
        $("#btnGrupoEstrategia").click(function () {
            AbrirGrupoEstrategia();
        });
    }

    function Inicializar() {
        _iniDialog();
        _bindingEvents();
    }

    return {
        Inicializar: Inicializar
    }

});
