<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebTracking.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.WebTracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SOMOS BELCORP - SEGUIMIENTO DE TUS PEDIDOS</title>
    <link href="~/Content/Css/WebTracking/style.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/Css/ui.jquery/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700italic,300,700,900" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var secuenciaAyuda = 1;

        function jScript() {

            $('#popupAyuda').dialog({
                width: 'auto',
                resizable: false,
                modal: true,
                autoOpen: false,
                closeOnEscape: false,
                draggable: true,
                open: function (event, ui) {
                    $(this).parent().appendTo("form1");
                    $(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').hide();
                    $(".ui-dialog-titlebar").hide();
                },
                close: function () { }
            });

            $('#btnMostrarAyuda').click(function (e) {
                mostrarAyuda();
                e.preventDefault();
            });

            $('#btnContinuar').click(function (e) {
                continuarAyuda();
                e.preventDefault();
            });

            $('#btnCerrar').click(function (e) {
                cerrarAyuda();
                e.preventDefault();
            });
        }

        function openAyuda() {
            $('#popupAyuda').dialog('open');
        }

        function mostrarAyuda() {
            secuenciaAyuda = 1;
            $('#lblTituloAyuda').text('¿Cómo hacer tracking a mis pedidos?');
            $('#lblTextoAyuda').html('<br/>Fácil, se mostrarán tus últimos 4 pedidos --&gt; Solo debes dar click en la figura que se muestra a continuación sobre cada pedido que deseas ver.<br/>');
            $('#imgImagenAyuda').show();
            $('#btnContinuar').show();
            $('#popupAyuda').dialog('open');
        }

        function continuarAyuda() {

            switch (secuenciaAyuda) {
                case 1:
                    $('#lblTituloAyuda').text('Etapas del tracking de pedido:');
                    $('#lblTextoAyuda').html('<br/>Al lado izquierdo tendras 6 etapas, desde que digitaste tu pedido hasta que llego a tu puerta.<br/>');
                    $('#imgImagenAyuda').hide();
                    $('#btnContinuar').show();
                    break;
                case 2:
                    $('#lblTituloAyuda').text('Definicion de las etapas:');
                    var texto = '<table>';
                    texto += '<tr><td style="width: 50px;">Etapa 1 </td><td>Pedido Recibido: </td><td>Indica la fecha y hora de cuando tu pedido ingreso a nuestro sistema.</td></tr>';
                    texto += '<tr><td style="width: 50px;">Etapa 2 </td><td>Facturado: </td><td>Indica la fecha que tu pedido ha sido facturado.</td></tr>';
                    texto += '<tr><td style="width: 50px;">Etapa 3 </td><td>Inicio de Armado: </td><td>Te indica a que hora inicio el armado de tu caja de pedido.</td></tr>';
                    //texto += '<tr><td style="width: 50px;">Etapa 4 </td><td>Chequeado: </td><td>Indica la fecha y la hora que tu pedido tuvo una revisión adicional después de ser armado(Estas revisiones se hacen en forma aleatoria).</td></tr>';
                    texto += '<tr><td style="width: 50px;">Etapa 4 </td><td>Puesto en transporte: </td><td>Indica la fecha y hora en que tu pedido sale de Belcorp y se carga en el camión que lo llevará a destino.</td></tr>';
                    texto += '<tr><td style="width: 50px;">Etapa 5 </td><td>Fecha Estimada de Entrega: </td><td>Te indica la fecha estimada en el cual tu pedido te llegará a tu domicilio.</td></tr>';
                    texto += '<tr><td style="width: 50px;">Etapa 6 </td><td>Entregado: </td><td>Fecha que tu pedido fue entregado en tu domicilio*.</td></tr>';
                    texto += '<tr><td></td><td colspan="2"><br/>* En estos momentos este hito no es en línea (está en desarrollo), el registro de ENTREGADO podría variar sin embargo el pedido ya estará en tu poder.</td></tr>';
                    texto += '</table>';
                    $('#lblTextoAyuda').html(texto);
                    $('#imgImagenAyuda').hide();
                    $('#btnContinuar').hide();
                    break;
            }

            secuenciaAyuda = secuenciaAyuda + 1;
        }

        function cerrarAyuda() {

            $('#popupAyuda').dialog('close');

            var opcion = $('#<%= CheckBoxNo.ClientID %>').attr("checked");
            if (opcion == 'checked') {

                $('#<%= HidMostrarAyuda.ClientID %>').val('1');
                $('#<%= BtnCancel.ClientID %>').trigger('click');
            }
        }

        function CargarMapa(latitud, longitud, novedad) {
            InitCargarImagen(novedad);
            $('#pMapa').show();

            if (latitud == '' || longitud == '') return;

            var myLatLng = new google.maps.LatLng(latitud, longitud);
            var mapOptions = { zoom: 16, center: myLatLng };
            var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

            var beachMarker = new google.maps.Marker({
                position: myLatLng,
                map: map,
                icon: '../Content/Images/webtracking/marker.png'
            });
        }
        //R20150710
        function CargarFoto(imagenExiste, urlImagen, novedad) {
            InitCargarImagen(novedad);
            $('#pFoto').show();
            CargarImagen($('#fot-canvas'), imagenExiste, urlImagen);
        }
        //R20150710
        function CargarBoleta(imagenExiste, urlImagen, novedad) {
            InitCargarImagen(novedad);
            $('#pBoleta').show();
            CargarImagen($('#bol-canvas'), imagenExiste, urlImagen);
        }

        function InitCargarImagen(novedad) {
            $('#pFoto').hide();
            $('#pBoleta').hide();
            $('#pMapa').hide();

            if (novedad == "Entrega") {
                $('#NroNovedad').text('Nro. Pedido:');
                $('#FechaNovedad').text('F. Recibido Pedido:');
            } else {
                $('#NroNovedad').text('Nro. Recojo:');
                $('#FechaNovedad').text('F. Recojo Pedido:');
            }
        }
        function CargarImagen(objDiv, imagenExiste, urlImagen) {
            if (imagenExiste == 1) {
                objDiv.html('');
                ShowBackgroundCargando(objDiv);

                $('<img/>').attr('src', urlImagen)
                    .load(function () {
                        $(this).remove();
                        HideBackgroundCargando(objDiv, urlImagen);
                    })
                    .error(function () {
                        $(this).remove();
                        HideBackgroundCargando(objDiv, '');
                        ImagenNoDisponible(objDiv);
                    });
            }
            else ImagenNoDisponible(objDiv);
        }
        function ShowBackgroundCargando(objDiv) {
            objDiv
                .css('background-image', 'url(../Content/Images/Cargando.gif)')
                .css('background-size', '100px')
                .css('background-position-y', '0%');
        }
        function HideBackgroundCargando(objDiv, backgroundImage) {
            objDiv
                .css('background-image', 'url(' + backgroundImage + ')')
                .css('background-size', 'contain')
                .css('background-position-y', '');
        }
        function ImagenNoDisponible(objDiv) {
            objDiv.html("<span style='font-family: Arial; font-size: 18px; font-weight: bold; color: black; position: relative; line-height: 20;display: block;text-align: center;'>Imagen no disponible</span>");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upTracking" runat="server">
            <ContentTemplate>
                <script type="text/javascript">
                    Sys.Application.add_load(jScript);
                </script>
                <asp:MultiView ID="mvTracking" runat="server" ActiveViewIndex="0">
                    <asp:View ID="vTracking" runat="server">
                        <table style="width: 100%;">
                            <tr>
                                <td>                                                                        
                                    <table style="width: 100%;"> <!--ESTILOS DE LA PRIMERA GRILLA-->
                                        <tr>
                                            <td id="cellPedidos" runat="server" class="width_37" style="vertical-align: top; text-align: left">                                               
                                                <asp:Panel ID="pFiltros" runat="server" Width="100%"
                                                    ForeColor="#666666" GroupingText="Mis <b>pedidos</b>"
                                                    Font-Names="verdana" Font-Size="8pt" HorizontalAlign="Left">
                                                    <asp:GridView ID="gridPedidos" runat="server" AutoGenerateColumns="False" CssClass="tabla2 width_100"
                                                        GridLines="Horizontal" OnRowCommand="gridPedidos_RowCommand" CellPadding="0" CellSpacing="0">
                                                       
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Nro. Pedido">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblNumeroPedido" runat="server" Text='<%# Eval("NumeroPedido") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="F. Recibido Pedido">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFechaRecPed" runat="server" Text='<%# Eval("Fecha", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="25%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Campaña">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCampana" runat="server" Text='<%# Eval("Campana") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Estado">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("Estado") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Fecha" Visible="False">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Ver" ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnMostrar" runat="server" CommandName="MOSTRAR" CssClass="lupa_tracking"
                                                                        CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                                                        ImageUrl="~/Content/Images/webtracking/icono_lupa.png"  />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%" />
                                                            </asp:TemplateField>
                                                        </Columns>

                                                        <HeaderStyle Font-Size="11pt" ForeColor="#666565" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <RowStyle HorizontalAlign="Center" />

                                                    </asp:GridView>
                                                </asp:Panel>                                                                                       
                                                
                                                <asp:HyperLink ID="lnkPoliticasVenta" runat="server" 
                                                    NavigateUrl="../Content/FAQ/Politica_de_reclamos_CO.pdf" Target="_blank"
                                                    Style="padding-left: 2%; font-size: 14px; display: inline-block;
                                                        vertical-align: top; width: 49%; background: url(../Content/Images/Esika/indicador_pedido.png) no-repeat;
                                                        background-position: 0px 5px; font-family: 'lato'; color: black;
                                                        margin-top: 25px; font-weight: 700;">
                                                    Políticas Post Venta
                                                </asp:HyperLink>
                                                <asp:Panel ID="pPostVenta" runat="server" Width="100%"
                                                    ForeColor="#666666" GroupingText="Mis <b>postventas<b>"
                                                    Font-Names="verdana" Font-Size="12pt" HorizontalAlign="Left" Visible="false">
                                                    <asp:GridView ID="gridPostVenta" runat="server" AutoGenerateColumns="False" CssClass="tabla2"  Width="100%"
                                                        GridLines="Horizontal" CellPadding="0" CellSpacing="0" OnRowCommand="gridPostVenta_RowCommand" DataKeyNames="EstadoRecojoID">

                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Ver" ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnMostrar" runat="server" CommandName="MOSTRAR"
                                                                        CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                                                        ImageUrl="~/Content/Images/webtracking/boxGrande.png" Width="55px" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Nro. Recojo">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblNumeroRecojo" runat="server" Text='<%# Eval("NumeroRecojo") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="25%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="F. Recojo">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFechaRecojo" runat="server" Text='<%# Eval("FechaRecojo", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Campaña">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCampana" runat="server" Text='<%# Eval("Campania") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Estado">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("EstadoRecojo") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateField>
                                                            <%--<asp:TemplateField HeaderText="Fecha" Visible="False">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                                        </Columns>

                                                        <HeaderStyle Font-Size="11pt" Height="30px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <RowStyle HorizontalAlign="Center" />

                                                    </asp:GridView>
                                                </asp:Panel>

                                            </td>
                                            <td class="width_50" style="vertical-align: super; text-align: center"><!--AÑADIR CLASE "width_100" PARA PÁGINA DE MIS PEDIDOS-->
                                                <asp:Panel ID="pnlSeguimientoPedido" runat="server" Width="100%"
                                                    CssClass="qpanelBorder" ForeColor="#666666" GroupingText="Seguimiento <b>del Pedido</b>"
                                                     Font-Size="10pt" HorizontalAlign="Left">
                                                    <div style="font-size: 12px; width: 100%; text-align: center;">
                                                        <asp:UpdateProgress ID="upProgress" runat="server" DisplayAfter="0">
                                                            <ProgressTemplate>
                                                                <img src="../Content/Images/webtracking/cargando.gif" width="18px" />
                                                                Cargando...
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </div>
													<!-- R2004 -->
                                                    <asp:Panel ID="pnlStatusGeneral" runat="server" Visible="false">
                                                        <div>
                                                            <b>ESTADO</b>: <asp:Label ID="lblEstadoFacturacion" runat="server" ForeColor="Red"></asp:Label> 
                                                        </div>
                                                        <div>
                                                            <b>MOTIVO</b>: <asp:Label ID="lblNovedadFacturacion" runat="server" ForeColor="Red"></asp:Label> 
                                                        </div>
                                                        <br />
                                                    </asp:Panel>

                                                    <asp:Panel ID="pnlSinTracking" runat="server" Visible="false">
                                                        <div>
                                                            <asp:Label ID="lblMensajeSinTracking" runat="server" ForeColor="Red"></asp:Label> 
                                                        </div>
                                                        <br />
                                                    </asp:Panel>

                                                    <asp:GridView ID="gridDatos" runat="server" AutoGenerateColumns="False" CssClass="tabla2"
                                                        GridLines="Horizontal" OnRowDataBound="gridDatos_RowDataBound" CellPadding="0" OnRowCommand="gridDatos_RowCommand">

                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Etapa">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEtapa" runat="server" Text='<%# ((GridViewRow) Container).RowIndex + 1 %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="2%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Image ID="imgMuestra" runat="server" Width="50px" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="1%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Situación">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSituacion" runat="server" Text='<%# Eval("Situacion") %>' Font-Size="10pt"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="35%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Fecha">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("CodigoConsultora") %>' Font-Size="10pt" color="black"></asp:Label>
                                                                    <asp:Label ID="lblTextoValorTurno" Text='<%#Eval("ValorTurno")%>' runat="server" Font-Size="8pt"></asp:Label>
                                                                    <asp:Label ID="lblTexto" runat="server" Text='<%# Eval("NumeroPedido") %>' Font-Size="10pt" Visible="false"></asp:Label>
                                                                    <asp:LinkButton ID="imgSegPed" runat="server" CommandName="NOVEDADES" Text="AQUI" Width="28px" Visible="false" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="35%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="" ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblHoraEstimadaDesdeHasta" runat="server" Text='<%# Eval("HoraEstimadaDesdeHasta") %>' Font-Size="10pt" color="black"></asp:Label>
                                                                </ItemTemplate>
                                                                
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Image ID="imgSI" runat="server" ImageUrl="~/Content/Images/webtracking/si.png" Width="25px" />
                                                                    <asp:Image ID="imgNO" runat="server" ImageUrl="~/Content/Images/webtracking/no.png" Width="28px" />
                                                                    <asp:Image ID="imgNO2" runat="server" ImageUrl="~/Content/Images/webtracking/no2.png" Width="28px" Visible="false" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%" />
                                                            </asp:TemplateField>
                                                        </Columns>

                                                        <HeaderStyle Font-Size="11pt" Height="30px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <RowStyle HorizontalAlign="Center" />
                                                    </asp:GridView>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlSeguimientoPostVenta" runat="server" Width="100%"
                                                    CssClass="qpanelBorder" ForeColor="#666666" GroupingText="Seguimiento de <b>PostVenta<b>"
                                                    Font-Names="verdana" HorizontalAlign="Left" Visible="false">
                                                    <div style="font-size: 12px; width: 100%; text-align: center;">
                                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                                                            <ProgressTemplate>
                                                                <img src="../Content/Images/webtracking/cargando.gif" width="18px"/>
                                                                Cargando...
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </div>
													<!-- R2004 OJO-->
                                                    <asp:Panel ID="Panel4" runat="server" Visible="false">
                                                        <div>
                                                            <b>ESTADO</b>: <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label> 
                                                        </div>
                                                        <div>
                                                            <b>MOTIVO</b>: <asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label> 
                                                        </div>
                                                        <br />
                                                    </asp:Panel>
                                                    <asp:GridView ID="gridSeguimientoPostVenta" runat="server" AutoGenerateColumns="False" CssClass="tabla2"
                                                        GridLines="Horizontal"  CellPadding="0" CellSpacing="0" OnRowDataBound="gridSeguimientoPostVenta_RowDataBound" OnRowCommand="gridSeguimientoPostVenta_RowCommand">

                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Etapa">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEtapa" runat="server" Text='<%# ((GridViewRow) Container).RowIndex + 1 %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Image ID="imgMuestra" runat="server" Width="50px" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Situación">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSituacion" runat="server" Text='<%# Eval("Situacion") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="35%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Fecha">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("FechaEstimadoRecojo") %>'></asp:Label>
                                                                    <asp:Label ID="lblTexto" runat="server" Font-Size="8pt" Visible="false"></asp:Label>
                                                                    <asp:LinkButton ID="imgSegPed" runat="server" CommandName="NOVEDADES" Text="AQUI" Width="28px" Visible="false" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="35%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Image ID="imgSI" runat="server" ImageUrl="~/Content/Images/webtracking/si.png" Width="25px" Visible="false"/>
                                                                    <asp:Image ID="imgNO2" runat="server" ImageUrl="~/Content/Images/webtracking/no2.png" Width="28px" Visible="false"/>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%" />
                                                            </asp:TemplateField>
                                                        </Columns>

                                                        <HeaderStyle Font-Size="11pt" Height="30px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <RowStyle HorizontalAlign="Center" />
                                                    </asp:GridView>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" width="40%" style="vertical-align: top; text-align: left">
                                                <br />

                                               <%-- <a id="btnMostrarAyuda" href="javascript:void(0);">Mostrar ayuda</a>&nbsp;--%>
                                                <asp:Label ID="lblMensaje" runat="server" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Red" Visible="False"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <div id="popupAyuda" style="width: 500px; background-color: white; display: none;">
                            <div class="popupcontainertitle1" style="width: 100%">
                                <div class="cell popupcontainercell">
                                    <span id="lblTituloAyuda">¿Cómo hacer tracking a mis pedidos?
                                    </span>
                                </div>
                            </div>
                            <table style="width: 500px;">
                                <tr>
                                    <td colspan="2">
                                        <span id="lblTextoAyuda" style="font-family: Arial; font-size: 9pt; color: #999; height: 56px; width: 85%;">
                                            <br />
                                            Fácil, se mostrarán tus últimos 4 pedidos --&gt; Solo debes dar click en la figura que se muestra a continuación sobre cada pedido que deseas ver.<br />
                                        </span>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: center;">
                                        <img id="imgImagenAyuda" src="../Content/Images/webtracking/DETALLE1.png" style="height: 122px; width: 390px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="CheckBoxNo" runat="server" Font-Bold="False"
                                            Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"
                                            Text="No volver a mostrar esta ayuda al inicio." />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"></td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: right;">
                                        <input id="btnContinuar" type="button" value="Continuar" style="font-size: xx-small; font-weight: bold; height: 30px; width: 70px;" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input id="btnCerrar" type="button" value="Salir" style="font-size: xx-small; font-weight: bold; height: 30px; width: 70px;" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:HiddenField ID="HidMostrarAyuda" runat="server" Value="0" />
                        <asp:Button ID="BtnCancel" runat="server" OnClick="BtnCancel1_Click" Style="display: none;" />
                    </asp:View>
                    <asp:View ID="vNovedades" runat="server">
                        <table style="width: 100%;">
                            <tr>
                                <td><b id="NroNovedad">Nro. Pedido:</b>
                                    <asp:Label ID="lblNovNroPedido" runat="server"></asp:Label></td>
                                <td><b id="FechaNovedad">F. Recibido Pedido:</b>
                                    <asp:Label ID="lblNovFecha" runat="server"></asp:Label></td>
                                <td><b>Campaña:</b>
                                    <asp:Label ID="lblNovCampania" runat="server"></asp:Label></td>
                                <td><b>Estado:</b>
                                    <asp:Label ID="lblNovEstado" runat="server"></asp:Label></td>
                                <td>
                                    <div class="input_search">
                                        <asp:Button ID="btnRegresar" runat="server" Text="Regresar al detalle" OnClick="btnRegresar_Click" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="vertical-align: top; width: 100%;">
                                                <asp:Panel ID="pnlNovedadesEntrega" runat="server" Width="100%"
                                                    ForeColor="#666666" GroupingText="Novedades de la Entrega"
                                                    Font-Names="verdana" Font-Size="10pt" HorizontalAlign="Left">
                                                    <asp:GridView ID="gvNovedades" runat="server" AutoGenerateColumns="False" CssClass="tabla2" Width="100%"
                                                        GridLines="Horizontal" CellPadding="0" CellSpacing="0" OnRowCommand="gvNovedades_RowCommand" DataKeyNames="Latitud,Longitud,Foto,Boleta" OnRowDataBound="gvNovedades_RowDataBound">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Ver" ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnMostrar" runat="server" CommandName="Mapa"
                                                                        CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                                                        ImageUrl="~/Content/Images/webtracking/Icono_mapa.png" Width="24px" />
                                                                    <%--<!20150710 inicia agregar iconos>--%>
                                                                    <asp:ImageButton ID="btnFoto" runat="server" CommandName="Foto"
	                                                                    CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
	                                                                    ImageUrl="~/Content/Images/webtracking/Icono_foto.png" Width="24px" Visible="false"/>
                                                                    <asp:ImageButton ID="btnBoleta" runat="server" CommandName="Boleta"
	                                                                    CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
	                                                                    ImageUrl="~/Content/Images/webtracking/Icono_factura.png" Width="24px" Visible="false"/>
                                                                    <%--<!20150710 fin>--%>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Novedad">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblNumeroPedido" runat="server" Text='<%# Eval("DesNovedad") %>' Font-Size="10pt"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Mensaje">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCampana" runat="server" Text='<%# Eval("MensajeNovedad") %>' Font-Size="10pt"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="40%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Fecha y Hora">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("FechaNovedad") %>' Font-Size="10pt"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="25%" />
                                                            </asp:TemplateField>
                                                        </Columns>

                                                        <HeaderStyle Font-Size="11pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <RowStyle HorizontalAlign="Center" />

                                                    </asp:GridView>
                                                </asp:Panel>

                                                <asp:Panel ID="pnlNovedadesPostVenta" runat="server" Width="100%"
                                                    ForeColor="#666666" GroupingText="Novedades de PostVenta"
                                                    Font-Names="verdana"  HorizontalAlign="Left" Visible="false">
                                                    <asp:GridView ID="gvNovedadesPostVenta" runat="server" AutoGenerateColumns="False" CssClass="tabla2" Width="100%"
                                                        GridLines="Horizontal" CellPadding="0" CellSpacing="0" OnRowCommand="gvNovedadesPostVenta_RowCommand" OnRowDataBound="gvNovedadesPostVenta_RowDataBound" DataKeyNames="Latitud,Longitud,Foto1,Foto2">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Ver" ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnMostrar" runat="server" CommandName="Mapa"
                                                                        CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                                                        ImageUrl="~/Content/Images/webtracking/Icono_mapa.png" Width="24px" />
                                                                    <asp:ImageButton ID="btnFoto" runat="server" CommandName="Foto"
	                                                                    CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
	                                                                    ImageUrl="~/Content/Images/webtracking/Icono_foto.png" Width="24px" Visible="false"/>
                                                                    <asp:ImageButton ID="btnBoleta" runat="server" CommandName="Boleta"
	                                                                    CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
	                                                                    ImageUrl="~/Content/Images/webtracking/Icono_factura.png" Width="24px" Visible="false"/>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Novedad">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblNovedad" runat="server" Text='<%# Eval("Novedad") %>' Font-Size="10pt"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="25%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Mensaje">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblMensajeNovedad" runat="server" Text='<%# Eval("MensajeTipoNovedad") %>' Font-Size="10pt"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="40%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Fecha y Hora">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFechaRecojo" runat="server" Text='<%# Eval("FechaRecojo") %>' Font-Size="10pt"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="25%" />
                                                            </asp:TemplateField>
                                                        </Columns>

                                                        <HeaderStyle Font-Size="11pt"  HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <RowStyle HorizontalAlign="Center" />

                                                    </asp:GridView>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align: top; text-align: left">
                                                <asp:Panel ID="pMapa" runat="server" Width="100%"
                                                    CssClass="qpanelBorder margin_25" ForeColor="#666666" GroupingText="Ubicación de la Entrega"
                                                    Font-Names="verdana" Font-Size="10pt" HorizontalAlign="Left">
                                                    <div id="map-canvas" style="width: 100%; height: 400px;">
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pFoto" runat="server" Width="100%"
	                                                CssClass="qpanelBorder" ForeColor="#666666" GroupingText="Foto"
                                                    Font-Names="verdana" Font-Size="8pt" HorizontalAlign="Left">
                                                    <div id="fot-canvas" style="width: 100%; height: 400px;background-repeat:no-repeat;background-size:contain;background-position:center">
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pBoleta" runat="server" Width="100%"
                                                    CssClass="qpanelBorder" ForeColor="#666666" GroupingText="Boleta"
                                                    Font-Names="verdana" Font-Size="10pt" HorizontalAlign="Left"> 
                                                    <div id="bol-canvas" style="width: 100%; height: 400px;background-repeat:no-repeat;background-size:contain;background-position:center">
                                                    </div>
                                                </asp:Panel>


                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:View>

                </asp:MultiView>
            </ContentTemplate>
        </asp:UpdatePanel>


    </form>
</body>
</html>