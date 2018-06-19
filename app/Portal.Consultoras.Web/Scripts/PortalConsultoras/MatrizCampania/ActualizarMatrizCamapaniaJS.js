window.onload = function () {  
    var raiz = document.getElementById("hdfUrlRaiz").value;
    var urlBase = window.location.protocol + '//' + window.location.host + raiz;
    window.sessionStorage.setItem("urlBase", urlBase);

    document.getElementById('divArchivo').style.display = 'none';
    ConbfigurarTABS();
    ObtenerDatosMatrizCampania();
    document.getElementById('ddlPais').onchange = function () { ObtenerCampaniasByPais(document.getElementById('ddlPais').value); };
    document.getElementById('ddlPaisM').onchange = function () {
 
        document.getElementById('divregistrosValidos').style.display = 'None';
        document.getElementById('divRegistrosInvalidos').style.display = 'None';
        document.getElementById("uplArchivo").value = "";
        document.getElementById('divArchivo').style.display = 'none';
        ObtenerCampaniasByPaisMasivo(document.getElementById('ddlPaisM').value);
    };
    document.getElementById('btnBuscar').onclick = function () { ObtenerDescripcion(document.getElementById('txtCodVenta').value, document.getElementById('ddlCampania').value, document.getElementById('ddlPais').value) };
    document.getElementById('btnGrabar').onclick = function () { GrabarMatrizCampania(); };
    document.getElementById('uplArchivo').onchange = function (e) {ValidarExcel();};
    document.getElementById('uplArchivo').onclick = function (e) {

        if (document.getElementById('ddlPaisM').value == "" || document.getElementById('ddlCampaniaM').value=="0" ) {
            alert("Los campos Pais y Campañia son obligatorios.");
            return false;
        }
        e.target.value = '';
    }
    document.getElementById('btnProcesarMasivo').onclick = function () {
        //nroEnvio = 1;
        //GrabarMatrizBloque();
        GrabarMatrizCampaniaMasivo();
    }
    document.getElementById('ddlCampaniaM').onchange = function () {
        Limpiar();
    }
    document.getElementById('btnExcel').onclick = function () {
        exportar();
        //document.getElementById('tbInValidos').innerHTML = '<table id="testTable" summary="Code page support in different versions of MS Windows." rules="groups" frame="hsides" border="2"><caption>CODE-PAGE SUPPORT IN MICROSOFT WINDOWS</caption><colgroup align="center"></colgroup><colgroup align="left"></colgroup><colgroup span="2" align="center"></colgroup><colgroup span="3" align="center"></colgroup><thead valign="top"><tr><th>Code-Page<br>ID</th><th>Name</th><th>ACP</th><th>OEMCP</th><th>Windows<br>NT 3.1</th><th>Windows<br>NT 3.51</th><th>Windows<br>95</th></tr></thead><tbody><tr><td>1200</td><td style="background-color: #00f; color: #fff">Unicode (BMP of ISO/IEC-10646)</td><td></td><td></td><td>X</td><td>X</td><td>*</td></tr><tr><td>1250</td><td style="font-weight: bold">Windows 3.1 Eastern European</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1251</td><td>Windows 3.1 Cyrillic</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1252</td><td>Windows 3.1 US (ANSI)</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1253</td><td>Windows 3.1 Greek</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1254</td><td>Windows 3.1 Turkish</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1255</td><td>Hebrew</td><td>X</td><td></td><td></td><td></td><td>X</td></tr><tr><td>1256</td><td>Arabic</td><td>X</td><td></td><td></td><td></td><td>X</td></tr><tr><td>1257</td><td>Baltic</td><td>X</td><td></td><td></td><td></td><td>X</td></tr><tr><td>1361</td><td>Korean (Johab)</td><td>X</td><td></td><td></td><td>**</td><td>X</td></tr></tbody><tbody><tr><td>437</td><td>MS-DOS United States</td><td></td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>708</td><td>Arabic (ASMO 708)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr><tr><td>709</td><td>Arabic (ASMO 449+, BCON V4)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr><tr><td>710</td><td>Arabic (Transparent Arabic)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr><tr><td>720</td><td>Arabic (Transparent ASMO)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr></tbody></table>';

        //document.getElementById('tablaCuvsInValidos').innerHTML ='<table id="testTable" rules="groups" frame="hsides" border="1"><thead valign="top"><tr><th>Code-Page</th><th>Name</th><th>ACP</th><th>OEMCP</th><th>Windows</th><th>Windows</th><th>Windows</th></tr></thead><tbody><tr><td>1200</td><td style="background-color: #00f; color: #fff">Unicode (BMP of ISO/IEC-10646)</td><td></td><td></td><td>X</td><td>X</td><td>*</td></tr><tr><td>1250</td><td style="font-weight: bold">Windows 3.1 Eastern European</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1251</td><td>Windows 3.1 Cyrillic</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1252</td><td>Windows 3.1 US (ANSI)</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1253</td><td>Windows 3.1 Greek</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1254</td><td>Windows 3.1 Turkish</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td></tr><tr><td>1255</td><td>Hebrew</td><td>X</td><td></td><td></td><td></td><td>X</td></tr><tr><td>1256</td><td>Arabic</td><td>X</td><td></td><td></td><td></td><td>X</td></tr><tr><td>1257</td><td>Baltic</td><td>X</td><td></td><td></td><td></td><td>X</td></tr><tr><td>1361</td><td>Korean (Johab)</td><td>X</td><td></td><td></td><td>**</td><td>X</td></tr></tbody><tbody><tr><td>437</td><td>MS-DOS United States</td><td></td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>708</td><td>Arabic (ASMO 708)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr><tr><td>709</td><td>Arabic (ASMO 449+, BCON V4)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr><tr><td>710</td><td>Arabic (Transparent Arabic)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr><tr><td>720</td><td>Arabic (Transparent ASMO)</td><td></td><td>X</td><td></td><td></td><td>X</td></tr></tbody></table>'
       //tableToExcel('tablaCuvsInValidos', 'Articulos Invalidos');

    };
    document.getElementById('btnValidar').onclick = function () { ValidarInvalidos(); };

    //document.getElementById('imgValidar').onclick = function () {
    //    var file = document.getElementById("uplArchivo");
    //    if (document.getElementById('ddlCampaniaM').value != '0' && (file.value != null && file.value != "")) {
    //        ValidarExcel();
    //    }
    //    else
    //        alert('seleccione Campania y archivo a subir');
    //};
}

function GrabarMatrizCampania() {
    var vMessage = "";
    if (document.getElementById('txtDescripcionNueva').value.trim()=="") {
        vMessage += "- Debe ingresar descripción del producto.\n";
    }
    if (document.getElementById('txtPrecioNuevo').value.trim() == "") {
        vMessage += "- Debe ingresar precio del producto.\n";
    }
    if (document.getElementById('txtFactorRepeticionNuevo').value.trim() == "") {
        vMessage += "- Debe ingresar factor de repetición del producto.\n";
    }
    if (vMessage!="") {
        alert(vMessage);
        return false;
    } else
    {
        waitingDialog({});
        
        var item = {
            CUV: document.getElementById('txtCodVenta').value.trim(),
            CampaniaID: document.getElementById('ddlCampania').value,
            Descripcion: document.getElementById('txtDescripcionNueva').value,
            PaisID: document.getElementById('ddlPais').value,
            PrecioProducto: document.getElementById('txtPrecioNuevo').value.trim(),
            FactorRepeticion: document.getElementById('txtFactorRepeticionNuevo').value.trim() 
        };
        //if (_settings.habilitarRegalo) {
        //    item.RegaloDescripcion = $(_elements.txtRegaloDescripcion).val();
        //    var imagen = $(_elements.imgSeleccionada).attr('src');
        //    if (imagen != '' && imagen.indexOf('prod_grilla_vacio.png') == -1)
        //        item.RegaloImagenUrl = imagen.substr(imagen.lastIndexOf("/") + 1);
        //}

        var url = "MatrizCampania/InsertarProductoDescripcion";
        var urlBase = window.sessionStorage.getItem("urlBase");
        url = urlBase + url;

        $.ajax({
            url: url,
            type: "POST",
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(item),
            processData: false,
            success: function (data, textStatus, jQxhr) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
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
}

function GrabarMatrizBloque(){

    var tabla = document.getElementById('tbValidos');
    var anioCampania = document.getElementById('ddlCampaniaM').value;
    var pais = document.getElementById('ddlPaisM').value;
    var data = "";
    var nRegistros = tabla.rows.length;

    var bloque = (nroEnvio - 1) * nroRegEnv;
    var inicio = bloque;
    var fin = bloque + nroRegEnv;


    for (var i = inicio; i < fin; i++) {

        if (i < nRegistros) {

            data += anioCampania;
            data += "|";
            for (var j = 0; j < 4; j++) {
                data += tabla.rows[i].cells[j].innerHTML;
                data += "|";
            }
            data = data.substring(0, data.length - 1);
            data += '¬';


        }
        else break;      
    }
    data = data.substring(0, data.length - 1);
    data += data +'~'+ pais

    var url = "MatrizCampania/grabarBloque";
    var urlBase = window.sessionStorage.getItem("urlBase");
    url = urlBase + url;

    requestServer(url ,"POST", mostrarGrabar, data, null);
}

function GrabarMatrizCampaniaMasivo() {
    var tabla = document.getElementById('tbValidos');
    var anioCampania = document.getElementById('ddlCampaniaM').value;
    var pais = document.getElementById('ddlPaisM').value;
    var data = "";

    if (isNaN(pais)|| pais=="" || pais==null) {
        alert('Seleccionar País');
        return false;
    }
    if (anioCampania == "0" || anioCampania == "") {
        alert('Seleccionar Campañia');
        return false;
    }
    var Nfilas = tabla.rows.length;
    if (Nfilas<=0) {
        alert('No existe productos por Actualizar');
        return false;
    }

    for (var i = 0; i < Nfilas; i++) {
        data += anioCampania;
        data += "|";
        for (var j = 0; j < 4; j++) {
            data += tabla.rows[i].cells[j].innerHTML;
            data += "|";
        }
        data = data.substring(0, data.length-1);
        data += '¬';
    }

    data = data.substring(0, data.length - 1);


    var item = {
        paisID: pais,
        data: data
    };
    var url = "MatrizCampania/InsertarProductoMasivo";
    var urlBase = window.sessionStorage.getItem("urlBase");
    url = urlBase + url;

    $.ajax({
        url: url,
        type: "POST",
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(item),
        processData: false,
        success: function (data, textStatus, jQxhr) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert(data + ' registros procesados correctamente');
               
                var myTable = document.getElementById("tbValidos");
                var rowCount = myTable.rows.length;
                for (var x = rowCount - 1; x >=0; x--) {
                    myTable.deleteRow(x);
                }
                document.getElementById('spanTotales1').innerHTML = document.getElementById('spanInValido').innerHTML;
                document.getElementById('spanValido').innerHTML = '0';
                document.getElementById('spanTotales2').innerHTML = document.getElementById('spanInValido').innerHTML;
                
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

function ObtenerDescripcion(CodVenta, IDCampania, paisID) {

    var vMessage = "";
    if (document.getElementById('ddlPais').value == "" || isNaN(document.getElementById('ddlPais').value)) {
        vMessage += "- Debe seleccionar el país.\n";
        document.getElementById('ddlPais').focus();
        alert(vMessage);
        return false;
    }
    if (document.getElementById('ddlCampania').value == "" || document.getElementById('ddlCampania').value==0) {
        vMessage += "- Debe seleccionar la campaña.\n";
        document.getElementById('ddlCampania').focus();
        alert(vMessage);
        return false;
    }
    if (document.getElementById('txtCodVenta').value.trim() == "") {
        vMessage += "- Debe ingresar código único de venta.\n";
        alert(vMessage);
        document.getElementById('txtCodVenta').focus();
        return false;
    }
    waitingDialog({});
    var url = "MatrizCampania/ConsultarDescripcion";
    var urlBase = window.sessionStorage.getItem("urlBase");
    url = urlBase + url;

    $.ajax({
        url: url,
        type: "POST",
        contentType: 'application/json',
        data: JSON.stringify({ CUV: CodVenta, IDCampania: IDCampania, paisID: paisID}),
        processData: false,
        success: function (data, textStatus, jQxhr) {

            if (data.success == false) {
                document.getElementById('txtDescripcion').value = "";
                document.getElementById('txtPrecio').value = "";
                document.getElementById('txtFactorRepeticion').value = "";
                document.getElementById('txtDescripcionNueva').value = "";
                document.getElementById('txtPrecioNuevo').value = "";
                document.getElementById('txtFactorRepeticionNuevo').value = "";
                alert(data.message);
                closeWaitingDialog();
                return false;
            }
            if (data.lstProducto.length > 0) {
                //$(_elements.hdnSap).val(data.lstProducto[0].SAP);
                //$(_elements.hdnIdMatrizComercial).val(data.lstProducto[0].IdMatrizComercial);
                document.getElementById('txtDescripcion').value=data.lstProducto[0].Descripcion;
                document.getElementById('txtPrecio').value=data.lstProducto[0].PrecioProducto;
                document.getElementById('txtFactorRepeticion').value=data.lstProducto[0].FactorRepeticion;
            }
            if (data.lstProducto.length == 2) {
                document.getElementById('txtDescripcionNueva').value = data.lstProducto[1].Descripcion;
                document.getElementById('txtPrecioNuevo').value = data.lstProducto[1].PrecioProducto;
                document.getElementById('txtFactorRepeticionNuevo').value = data.lstProducto[1].FactorRepeticion;
                //if (_settings.habilitarRegalo) {
                //    $(_elements.txtRegaloDescripcion).val(data.lstProducto[1].RegaloDescripcion);
                //    if ($.trim(data.lstProducto[1].RegaloImagenUrl) != '') {
                //        $(_elements.imgSeleccionada).attr("src", data.lstProducto[1].RegaloImagenUrl);
                //    }
                //}

            }

            closeWaitingDialog();
        },
        error: function (jqXhr, textStatus, errorThrown) {
            console.log(errorThrown);
        }
    });
}

function ObtenerCampaniasByPais(paisId2) {
    var url = "MatrizCampania/CargarCampania";
    var urlBase = window.sessionStorage.getItem("urlBase");
    url = urlBase + url;

    $.ajax({
        url: url,
        type: "POST",
        contentType: 'application/json',
        data: JSON.stringify({ paisId: paisId2}),
        processData: false,
        success: function (data, textStatus, jQxhr) {
            llenarComboAnioCampania(data.DropDownListCampania,'ddlCampania');
        },
        error: function (jqXhr, textStatus, errorThrown) {
            console.log(errorThrown);
        }
    });
}
function ObtenerCampaniasByPaisMasivo(paisId2) {

    var url = "MatrizCampania/CargarCampania";
    var urlBase = window.sessionStorage.getItem("urlBase");
    url = urlBase + url;

    $.ajax({
        url: url,
        type: "POST",
        contentType: 'application/json',
        data: JSON.stringify({ paisId: paisId2 }),
        processData: false,
        success: function (data, textStatus, jQxhr) {
            llenarComboAnioCampania(data.DropDownListCampania, 'ddlCampaniaM');
            document.getElementById('ddlCampaniaM').removeAttribute('disabled');
        },
        error: function (jqXhr, textStatus, errorThrown) {
            console.log(errorThrown);
        }
    });
}


function ObtenerDatosMatrizCampania() {

    var url = "MatrizCampania/ObtenerDatosMatrizCampania";
    var urlBase = window.sessionStorage.getItem("urlBase");
    url = urlBase + url;

    $.ajax({
        url: url,
        //dataType: 'json',
        type: 'post',
        contentType: 'application/json',
        //data: JSON.stringify({ "first-name": $('#first-name').val(), "last-name": $('#last-name').val() }),
        processData: false,
        success: function (data, textStatus, jQxhr) {
         //   console.log(data);
            llenarComboPais(data.listaPaises);
        },
        error: function (jqXhr, textStatus, errorThrown) {
            console.log(errorThrown);
        }
    });

}
function ConbfigurarTABS() {
    // Establece los efectos para cada uno de los Tabs
    $(".contenido_tab").hide(); //Ocultar capas
    $("ul.tabs li:first").addClass("activa").show(); //Activar primera pestaña
    $(".contenido_tab:first").show(); //Mostrar contenido primera pestaña

    // Sucesos al hacer click en una pestaña
    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("activa"); //Borrar todas las clases "activa"
        $(this).addClass("activa"); //Añadir clase "activa" a la pestaña seleccionada
        $(".contenido_tab").hide(); //Ocultar todo el contenido de la pestaña
        var activatab = $(this).find("a").attr("href"); //Leer el valor de href para identificar la pestaña activa
        $(activatab).fadeIn(); //Visibilidad con efecto fade del contenido activo

        return false;
    });
}
function llenarComboPais(data) {
    var options = "<option>-- Seleccionar -- </option>";
    for (var i = 0; i < data.length; i++) {
        options += "<option value=" + data[i].PaisID + ">";
        options += data[i].Nombre;
        options += "</option>";
    }
    document.getElementById('ddlPais').innerHTML = options;
    document.getElementById('ddlPaisM').innerHTML = options;   
}
function llenarComboAnioCampania(data, ddlCampania) {
var options = "";
    for (var i = 0; i < data.length; i++) {
        options += "<option value=" + data[i].CampaniaID + ">";
        options += data[i].Codigo;
        options += "</option>";
    }
    document.getElementById(ddlCampania).innerHTML = options;
}


var contValidos = 0;
var contInValidos = 0;
function ValidarExcel() {
    contValidos = 0;
    contInValidos = 0;
    var file = document.getElementById("uplArchivo");
    if (file != null && file != undefined) {
        waitingDialog({});
 
        var pais = document.getElementById("ddlPaisM").value;
        var anioCampania = document.getElementById('ddlCampaniaM').value;

        if (isNaN(pais) || pais == "" || pais == null) {
            alert('Seleccionar País');
            return false;
        }
        if (anioCampania == "0" || anioCampania == "") {
            alert('Seleccionar Campañia');
            return false;
        }

        var xhr = new XMLHttpRequest();
        var formData = new FormData();
        formData.append("pais", pais);
        formData.append('AnioCampania', anioCampania);
        formData.append('file', file.files[0],'arch.xls');
      
        var url = "MatrizCampania/leerArchivoExcel";
        var urlBase = window.sessionStorage.getItem("urlBase");
        url = urlBase + url;
        xhr.open('post', url);
        xhr.onreadystatechange = function () {
            if (xhr.status == 200 && xhr.readyState == 4) {
                var rpt = xhr.responseText.split('||');
                if (rpt == "-1") {
                    alert('Formato de archivo Excel-Incorrecto');
                    return false;
                }
                document.getElementById('tablaCuvsValidos').innerHTML = "";
                document.getElementById('tablaCuvsInValidos').innerHTML = "";
                if (rpt[0].length > 0) {
                    var regValidos = "", regInValidos = "";
                    rpt[0] = rpt[0].trim();
                    var data = rpt[0].split('¬');                                     
                    var CampoValidos = rpt[1];
                    var CamposNovalidos = rpt[2];
                    var cuvInValidados = rpt[3];

                    createTablaRegistrosValidos();
                    createTablaRegistrosInValidos();

                    for (var i = 0; i < data.length; i++) {
                        var colum = data[i].split('¦');
                        if (CampoValidos.indexOf(colum[0].toString()) >= 0 && cuvInValidados.indexOf(colum[0].toString()) < 0   ) {
                                var encontro = 0;
                                var listaCamposNovalidos = CamposNovalidos.split('¬');

                                for (var g = 0; g < listaCamposNovalidos.length; g++) {
                                    var item = listaCamposNovalidos[g];
                                    if (item.indexOf(colum[0].toString()) >= 0 && item.indexOf(colum[1].toString()) >= 0 && item.indexOf(colum[2].toString()) >= 0 && item.indexOf(colum[3].toString()) >= 0) {

                                        var list = CamposNovalidos.split('¬');
                                        var listCuvInval = cuvInValidados.split('¬');
                                        contInValidos++;
                                        var cuv = "";
                                        regInValidos += "<tr style='background-color: white;'>";
                                        for (var j = 0; j < 4; j++) {
                                            cuv = colum[0];                                   
                                            regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'><div contenteditable='true'>";
                                           if (j == 2) {                                              
                                               if (isNaN(colum[j]) || colum[j].trim().length==0) {
                                                   regInValidos += colum[j];
                                               } else
                                                   regInValidos += parseFloat(colum[j]).toFixed(2);

                                            } else
                                                regInValidos += colum[j];
                                            regInValidos += "</div></td>";
                                        }

                                        var Obs = "";
                                        regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'>";
                                        for (var p = 0; p < list.length; p++) {
                                            if (cuv == list[p].split('¦')[0])
                                            {
                                                if (colum[1] == list[p].split('¦')[1] && colum[2] == list[p].split('¦')[2] && colum[3] == list[p].split('¦')[3] ) {
                                                    Obs += list[p].split('¦')[4];
                                                }                                       
                                            }
                                                
                                        }

                                        if (listCuvInval[0].trim().length>0) {
                                            for (var k = 0; k < listCuvInval.length; k++) {
                                                if (cuv == listCuvInval[k].split('¦')[0]) Obs += " - CUV no registrado en campaña seleccionada";
                                            }
                                        }
                                   
                                        regInValidos += Obs;
                                        regInValidos += "</td>";

                                        regInValidos += "</tr>";

                                        encontro = 1;
                                        break;

                                    }
                          
                                }

                                if (encontro == 1) {
                                    document.getElementById('divRegistrosInvalidos').style.display = 'block';
                                    document.getElementById('divExportarExcel').style.display = 'block';
                                    document.getElementById('spanInValido').innerHTML = contInValidos.toString();
                                    continue;
                                }
                   
                            contValidos++;
                            regValidos += "<tr style='background-color: white;'>";
                            for (var j = 0; j < 4; j++) {
                                //if (colum[j].trim().length <= 0) continue;
                                regValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'>";
                                if (j == 2) {
                                    if (isNaN(colum[j]) || colum[j].trim().length == 0) {
                                        regValidos += colum[j];
                                    }else
                                    regValidos += parseFloat(colum[j]).toFixed(2);
                                } else
                                    regValidos += colum[j];
                                regValidos += "</td>";
                            }
                            regValidos += "</tr>";

                            if (regValidos.length > 0) {
                                document.getElementById('divregistrosValidos').style.display = 'Block';
                                document.getElementById('divProcesarMasivo').style.display = 'Block';
                                document.getElementById('spanValido').innerHTML = contValidos.toString();
                                document.getElementById('divTotalRegistrosValidos').style.display = 'Inline-block';
                            } else {
                                document.getElementById('divregistrosValidos').style.display = 'None';
                                document.getElementById('divProcesarMasivo').style.display = 'None';
                                document.getElementById('spanValido').innerHTML = contValidos.toString();
                                document.getElementById('divTotalRegistrosValidos').style.display = 'None';
                            }

                            if (contInValidos == 0) {
                                document.getElementById('divRegistrosInvalidos').style.display = 'None';
                                document.getElementById('divExportarExcel').style.display = 'None';
                                document.getElementById('spanInValido').innerHTML = contInValidos.toString();
                            }

                        }
                        else
                        {
                            var cantCol = colum.length;
                            var cantVacios = 0;
                            var list = CamposNovalidos.split('¬');
                            var listCuvInval = cuvInValidados.split('¬');
                            for (var a = 0; a < cantCol; a++) {
                                if (colum[a].trim().length==0) 
                                    cantVacios++;
                                
                            }
                            if (cantVacios == cantCol) {
                                continue;
                            }

                                contInValidos++;
                                var cuv = "";
                                var descrip = "";
                                regInValidos += "<tr style='background-color: white;'>";
                                for (var j = 0; j < 4; j++) {
                                    cuv = colum[0];
                                    descrip = colum[1];
                                    //if (colum[j].trim().length <= 0 )continue;
                                    regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'><div contenteditable='true'>";
                                    //regInValidos += colum[j];
                                    if (j == 2) {
                                        if (isNaN(colum[j]) || colum[j].trim().length == 0) {
                                            regInValidos += colum[j];
                                        } else
                                            regInValidos += parseFloat(colum[j]).toFixed(2);
                                    } else
                                        regInValidos += colum[j];

                                    regInValidos += "</div></td>";
                                }

                                var Obs = "";
                                regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'>";
                                for (var p = 0; p < list.length; p++) {
                                    if (cuv == list[p].split('¦')[0])
                                    {
                                        if (descrip == list[p].split('¦')[1] && colum[2] == list[p].split('¦')[2] && colum[3] == list[p].split('¦')[3]) {
                                            Obs += list[p].split('¦')[4];
                                        }
                                    }
                                                                              
                                }

                                if (listCuvInval[0].trim().length > 0) {
                                    for (var k = 0; k < listCuvInval.length; k++) {
                                        if (cuv == listCuvInval[k].split('¦')[0]) Obs += " - CUV no registrado en campaña seleccionada";
                                    }
                                }
                              
                                regInValidos += Obs;
                                regInValidos += "</td>";

                                regInValidos += "</tr>";

                                if (regInValidos.length > 0) {
                                    document.getElementById('divRegistrosInvalidos').style.display = 'Block';
                                    document.getElementById('divExportarExcel').style.display = 'Inline-block';
                                    document.getElementById('spanInValido').innerHTML = contInValidos.toString();
                                    document.getElementById('divTotalRegistrosInvalidos').style.display = 'Inline-block';
                                }
                                else {
                                    document.getElementById('divRegistrosInvalidos').style.display = 'None';
                                    document.getElementById('divExportarExcel').style.display = 'None';
                                    document.getElementById('spanInValido').innerHTML = contInValidos.toString();
                                    document.getElementById('divTotalRegistrosInvalidos').style.display = 'None';
                                }

                                if (contValidos == 0) {
                                    document.getElementById('divregistrosValidos').style.display = 'None';
                                    document.getElementById('divProcesarMasivo').style.display = 'None';
                                    document.getElementById('spanValido').innerHTML = contValidos.toString();
                                    //document.getElementById('divTotalRegistrosValidos').style.display = 'None';
                                }

                           

                        }

                    }

                    document.getElementById('tbValidos').innerHTML = regValidos;
                    document.getElementById('tbInValidos').innerHTML = regInValidos;

                    document.getElementById('spanTotales1').innerHTML = (contValidos + contInValidos);
                    document.getElementById('spanTotales2').innerHTML = (contValidos + contInValidos);
         
                    
   
                }

            }
            closeWaitingDialog();
        }
        xhr.send(formData);
    } else {
        alert("seleccione archivo");
    }

   

}

function ValidarInvalidos() {
    waitingDialog({});
    var tabla = document.getElementById('tbInValidos');
    var anioCampania = document.getElementById('ddlCampaniaM').value;
    var pais = document.getElementById('ddlPaisM').value;
    var data = "";


    if (isNaN(pais) || pais == "" || pais == null) {
        alert('Seleccionar País');
        return false;
    }
    if (anioCampania == "0" || anioCampania == "") {
        alert('Seleccionar Campañia');
        return false;
    }
    var Nfilas = tabla.rows.length;
    if (Nfilas <= 0) {
        alert('No existe productos por Validar');
        return false;
    }



    for (var i = 0; i < Nfilas; i++) {
        for (var j = 0; j < 4; j++) {
            data += tabla.rows[i].cells[j].firstChild.innerText;
            data += "¦";
        }
        data = data.substring(0, data.length - 1);
        data += '¬';
    }
    data = data.substring(0, data.length - 1);
    var item = {
        pais: pais,
        AnioCampania: anioCampania,
        data: data
    };

    contInValidos = 0;

    var url = "MatrizCampania/ValidartablaInvalidosMasivo";
    var urlBase = window.sessionStorage.getItem("urlBase");
    url = urlBase + url;

    $.ajax({
        url: url,
        type: "POST",
        dataType: 'Text',
        contentType: 'application/json',
        data: JSON.stringify(item),
        processData: false,
        success: function (data, textStatus, jQxhr) {
            if (checkTimeout(data)) {
              
                var rpt = data.split('||');

                if (rpt[0].length > 0) {

                    var regInValidos = "";
                    rpt[0] = rpt[0].replace('¦¬¦', '');
                    var data = rpt[0].split('¬');
                    

                    var CampoValidos = rpt[1];
                    var CamposNovalidos = rpt[2];
                    var cuvInValidados = rpt[3];
                    
                    for (var i = 0; i < data.length; i++) {
                        var colum = data[i].split('¦');

                        

                        if (CampoValidos.indexOf(colum[0].toString()) >= 0 && cuvInValidados.indexOf(colum[0].toString()) < 0 && (colum[0].toString().length > 0 && colum[1].toString().length > 0 && colum[2].toString().length > 0 && colum[3].toString().length > 0)  ) {
                            contValidos++;


                            var encontro = 0;
                            var listaCamposNovalidos = CamposNovalidos.split('¬');

                            for (var g = 0; g < listaCamposNovalidos.length; g++) {
                                var item = listaCamposNovalidos[g];
                                //if (item.indexOf(colum[0].toString()) >= 0 && item.indexOf(colum[1].toString()) >= 0) {
                                if (item.indexOf(colum[0].toString()) >= 0 && item.indexOf(colum[1].toString()) >= 0 && item.indexOf(colum[2].toString()) >= 0 && item.indexOf(colum[3].toString()) >= 0) {

                                    var list = CamposNovalidos.split('¬');
                                    var listCuvInval = cuvInValidados.split('¬');
                                    contInValidos++;
                                    var cuv = "";
                                    var descrip = "";
                                    regInValidos += "<tr style='background-color: white;'>";
                                    for (var j = 0; j < 4; j++) {
                                        cuv = colum[0];
                                        descrip = colum[1];
                                        regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'><div contenteditable='true'>";
                                        //regInValidos += colum[j];
                                        if (j == 2) {
                                       
                                            if (isNaN(colum[j]) || colum[j].trim().length == 0) {
                                                regInValidos += colum[j];
                                            } else
                                                regInValidos += parseFloat(colum[j]).toFixed(2);
                                        } else
                                            regInValidos += colum[j];

                                        regInValidos += "</div></td>";
                                    }

                                    var Obs = "";
                                    regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'>";
                                   
                                    for (var p = 0; p < list.length; p++) {
                                        //if (cuv == list[p].split('¦')[0] && descrip == list[p].split('¦')[1]) Obs += list[p].split('¦')[2];
                                        if (cuv == list[p].split('¦')[0]) {
                                            if (descrip == list[p].split('¦')[1] && colum[2] == list[p].split('¦')[2] && colum[3] == list[p].split('¦')[3]) {
                                                Obs += list[p].split('¦')[4];
                                            }
                                        }


                                    }

                                    if (listCuvInval[0].trim().length > 0) {
                                        for (var k = 0; k < listCuvInval.length; k++) {
                                            if (cuv == listCuvInval[k].split('¦')[0]) Obs += " - CUV no registrado en campaña seleccionada";//&& descrip == list[p].split('¦')[1]
                                        }
                                    }

                                    regInValidos += Obs;
                                    regInValidos += "</td>";

                                    regInValidos += "</tr>";

                                    encontro = 1;
                                    break;

                                }

                            }

                            if (encontro == 1) {
                                document.getElementById('tbInValidos').innerHTML = regInValidos;
                                continue;
                            }

                            var tabla = document.getElementById('tbValidos');
                            var row = tabla.insertRow(-1);
                            var cell1 = row.insertCell(0);
                            var cell2 = row.insertCell(1);
                            var cell3 = row.insertCell(2);
                            var cell4 = row.insertCell(3);

                            cell1.innerHTML = "<td style='background-color: white;border-style: solid;border-width: 1px;text-align: center;'>"+ colum[0] + "</td>";
                            cell2.innerHTML = "<td style='background-color: white;border-style: solid;border-width: 1px;text-align: center;'>" + colum[1] + "</td>"; 
                            cell3.innerHTML = "<td style='background-color: white;border-style: solid;border-width: 1px;text-align: center;'>" + colum[2] + "</td>";
                            cell4.innerHTML = "<td style='background-color: white;border-style: solid;border-width: 1px;text-align: center;'>" + colum[3] + "</td>";

                                                 
                            cell1.style.backgroundColor = "white";
                            cell2.style.backgroundColor = "white";
                            cell3.style.backgroundColor = "white";
                            cell4.style.backgroundColor = "white";


                            cell1.style.borderStyle = "solid";
                            cell2.style.borderStyle = "solid";
                            cell3.style.borderStyle = "solid";
                            cell4.style.borderStyle = "solid";

                            cell1.style.borderWidth = "1px";
                            cell2.style.borderWidth = "1px";
                            cell3.style.borderWidth = "1px";
                            cell4.style.borderWidth = "1px";

                            cell1.style.textAlign  = "center";
                            cell2.style.textAlign  = "center";
                            cell3.style.textAlign  = "center";
                            cell4.style.textAlign  = "center";
                        
                                document.getElementById('divregistrosValidos').style.display = 'Block';
                                document.getElementById('divProcesarMasivo').style.display = 'Block';
                                document.getElementById('spanValido').innerHTML = contValidos.toString();
                                document.getElementById('divTotalRegistrosValidos').style.display = 'Inline-block';
                                document.getElementById('spanInValido').innerHTML = contInValidos.toString();
              

                            if (contInValidos == 0) {
                                document.getElementById('divRegistrosInvalidos').style.display = 'None';
                                document.getElementById('divExportarExcel').style.display = 'None';
                                document.getElementById('spanInValido').innerHTML = contInValidos.toString();
                                document.getElementById('divTotalRegistrosInvalidos').style.display = 'None';
                            }

                        }
                        else {
                            
                            var list = CamposNovalidos.split('¬');
                            var listCuvInval = cuvInValidados.split('¬');
                            contInValidos++;
                            var cuv = "";
                            var descrip = "";
                            regInValidos += "<tr style='background-color: white;'>";
                            for (var j = 0; j < 4; j++) {
                                cuv = colum[0];
                                descrip = colum[1];
                                //if (colum[j].trim().length <= 0) continue;
                                regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'><div contenteditable='true'>";
                                //regInValidos += colum[j];
                                if (j == 2) {
                                    if (isNaN(colum[j]) || colum[j].trim().length == 0) {
                                        regInValidos += colum[j];
                                    } else
                                        regInValidos += parseFloat(colum[j]).toFixed(2);
                                } else
                                    regInValidos += colum[j];

                                regInValidos += "</div></td>";
                            }

                            var Obs = "";
                            regInValidos += "<td style='border-style: solid;border-width: 1px;text-align: center;'>";


                            for (var p = 0; p < list.length; p++) {
                                //if (cuv == list[p].split('¦')[0] && descrip == list[p].split('¦')[1]) Obs += list[p].split('¦')[2];
                                if (cuv == list[p].split('¦')[0]) {
                                    if (descrip == list[p].split('¦')[1] && colum[2] == list[p].split('¦')[2] && colum[3] == list[p].split('¦')[3]) {
                                        Obs += list[p].split('¦')[4];
                                    }
                                }

                            }
                            if (listCuvInval[0].trim().length > 0) {
                                for (var k = 0; k < listCuvInval.length; k++) {
                                    if (cuv == listCuvInval[k].split('¦')[0]) Obs += " - CUV no registrado en campaña seleccionada";
                                }
                            }
                            regInValidos += Obs;
                            regInValidos += "</td>";

                            regInValidos += "</tr>";

                        }

                        if (regInValidos.length > 0) {
                            createTablaRegistrosInValidos();
                            document.getElementById('tbInValidos').innerHTML = regInValidos;
                            document.getElementById('divRegistrosInvalidos').style.display = 'Block';
                            document.getElementById('divExportarExcel').style.display = 'Inline-block';
                            document.getElementById('spanInValido').innerHTML = contInValidos.toString();
                            document.getElementById('divTotalRegistrosInvalidos').style.display = 'Inline-block';
                        }



                    }
                    //document.getElementById('tbValidos').innerHTML = regValidos;
                }

                closeWaitingDialog();
             
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

function createTablaRegistrosValidos() {    
    var tabla="";
    tabla += "<table style='border-style:solid;border-width:1px;width:98%;'><thead style='background-color: #ADFF2F;'><tr><th>CUV</th><th>Descripción</th><th>Precio Producto</th><th>Factor Repetición</th></tr></thead><tbody id='tbValidos'></tbody></table>";
    document.getElementById('tablaCuvsValidos').innerHTML = tabla;
}

function createTablaRegistrosInValidos() {
    var tabla = "";
    tabla += "<table style='border-style:solid;border-width:1px;width:98%;'><thead style='background-color:#CD5C5C;color:white'><tr><th>CUV</th><th>Descripción</th><th>Precio Producto</th><th>Factor Repetición</th><th>Observación</th></tr></thead><tbody id='tbInValidos'></tbody></table>";
    document.getElementById('tablaCuvsInValidos').innerHTML = tabla;
}

function exportar() {
        var tabla = document.getElementById('tbInValidos');
       
        var cnt = "<html><head><meta charset='utf-8'/></head><table style='table-layout:fixed'><thead>";
            cnt += "<colgroup> <col style='width:100px'/> <col style='width:400px'/> <col style='width:100px'/> <col style='width:100px'/> <col style='width:500px'/></colgroup>";
            cnt += "<tr><th style='background-color:red'>CUV</th><th style='background-color:red'>Descripción</th><th style='background-color:red'>Precio</th><th style='background-color:red'>Factor Repetición</th><th style='background-color:red'>Observación</th></tr>";
            cnt += "</thead><tbody>";
            for (var i = 0; i < tabla.rows.length; i++) {
            cnt += "<tr>";
            for (var j = 0; j < 5; j++) {
                cnt += "<td>";
                cnt += tabla.rows[i].cells[j].innerHTML;
                cnt += "</td>";
            }
            cnt += "</tr>";
            }
            cnt += "</tbody></table></html>";
        var formBlob = new Blob([cnt], { type: 'application/vnd.ms-excel' });
        var body = document.getElementsByTagName("body")[0];
        var href = document.createElement("a");
        href.href = window.URL.createObjectURL(formBlob);
        href.download = "ReporteProductosNoValidos.xls";
        body.insertAdjacentElement("beforeend", href);
        href.click();
        body.removeChild(href);
}

var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,'
        , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
        , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
        , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
    return function (table, name) {
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
        window.location.href = uri + base64(format(template, ctx))
    }
})()

function Limpiar() {
    document.getElementById('divregistrosValidos').style.display = 'None';
    document.getElementById('divRegistrosInvalidos').style.display = 'None';
    document.getElementById("uplArchivo").value = "";
    document.getElementById('divArchivo').style.display = 'block';

}
//grabar masivo

var nRegistros;
var nroRegRec = 100000;
var nroRegEnv = 10000;
var totalRec;
var totalEnv;
var nroEnvio = 0;
var regRecibidos = 0;
var regEnviados = 0;


function grabarBloque() {
    var bloque = (nroEnvio - 1) * nroRegEnv;
    var inicio = bloque;
    var fin = bloque + nroRegEnv;
    var data = "";
    
    for (var i = inicio; i < fin; i++) {
        if (i < nRegistros) {
            data += matriz[i].join("|");
            data += "¬";
        }
        else break;
    }
    data = data.substring(0, data.length - 1);
    requestServer("MatrizCampania/grabarBloque","POST", mostrarGrabar, data, null);
   
}

function mostrarGrabar(rpta) {
    if (rpta == "") {
        regEnviados += nroRegEnv;
        //document.getElementById("spnMensaje").innerHTML = "Envio Nro: " + nroEnvio + " - Duración Envio: " + tiempo + " msg - Reg Grabados: " + regEnviados;
        nroEnvio++;
        if (nroEnvio <= totalEnv) {
            grabarBloque();
        }
        else {
            //document.getElementById("spnMensaje").innerHTML = "Total Envios: " + totalEnv + " - Duración Total: " + tiempoTotal + " msg - Reg Grabados: " + nRegistros;
        }
    }
    else alert(rpta);
}

function requestServer(url, tipo, metodo, texto, metodoError) {
    var xhr = new XMLHttpRequest();
    xhr.open(tipo, url, true);
    xhr.onreadystatechange = function () {
        if (xhr.status == 200 && xhr.readyState == 4) {
            metodo(xhr.responseText);
        }
    }
    xhr.onerror = function () {
        console.log(xhr.responseText);
        metodoError();
    }
    if (tipo == "get") xhr.send();
    else {
        if (texto != null && texto != "") xhr.send(texto);
    }
}
