using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Portal.Consultoras.Web.Controllers;
using System.Configuration;
using Portal.Consultoras.Web.Models.AutoMapper;
//using System.IdentityModel;
//using System.IdentityModel.Services;
//using System.IdentityModel.Services.Configuration;
//using System.IdentityModel.Tokens;

namespace Portal.Consultoras.Web
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            //IoCConfig.RegistrarDependencias();
            Globals.RutaTemporales = HttpContext.Current.Server.MapPath("~/Content/Temporales"); // 1664
            Globals.RutaImagenesTemp = HttpContext.Current.Server.MapPath("~/Content/Images/temp");
            Globals.RutaImagenesTempOfertas = HttpContext.Current.Server.MapPath("~/Content/TemporalesOfertas");
            Globals.RutaImagenesFondoLogin = HttpContext.Current.Server.MapPath("~/Content/Images/login");
            Globals.RutaImagenesFondoPortal = HttpContext.Current.Server.MapPath("~/Content/Images/fondo");
            Globals.RutaImagenesLogoPortal = HttpContext.Current.Server.MapPath("~/Content/Images/logo");
            Globals.RutaImagenesOfertasWeb = HttpContext.Current.Server.MapPath("~/Content/Ofertas");
            Globals.RutaImagenesOfertasLiquidacion = HttpContext.Current.Server.MapPath("~/Content/OfertasLiquidacion");
            Globals.RutaImagenesMatriz = "/Content/Matriz"; // 1664
            //Globals.RutaImagenesMatriz = HttpContext.Current.Server.MapPath("~/Content/Matriz");
            Globals.RutaImagenesTempMatriz = HttpContext.Current.Server.MapPath("~/Content/TemporalesMatriz");
            Globals.RutaImagenesBanners = HttpContext.Current.Server.MapPath("~/Content/Banners");
            Globals.RutaImagenesTempBanners = HttpContext.Current.Server.MapPath("~/Content/TemporalesBanners");
            Globals.RutaImagenesTempLugaresPago = HttpContext.Current.Server.MapPath("~/Content/TemporalesLugaresPago");            
            //Globals.RutaImagenesLugaresPago = HttpContext.Current.Server.MapPath("~/Content/LugaresPago");
            Globals.RutaImagenesLugaresPago = "/Content/LugaresPago"; // 1664
            Globals.RutaImagenesTempIncentivos = HttpContext.Current.Server.MapPath("~/Content/TemporalesIncentivos");
            //Globals.RutaImagenesIncentivos = HttpContext.Current.Server.MapPath("~/Content/Incentivos");
            Globals.RutaImagenesIncentivos = "/Content/Incentivos"; // 1664
            //Globals.RutaImagenesOfertasNuevas = HttpContext.Current.Server.MapPath("~/Content/OfertasNuevas");
            Globals.RutaImagenesOfertasNuevas = "/Content/OfertasNuevas"; // 1664

            //**** 1664 Carpetas - Inicio *****//
            Globals.UrlBanner = ConfigurationManager.AppSettings["Banners"];
            Globals.UrlFileConsultoras = ConfigurationManager.AppSettings["FileConsultoras"];
            Globals.UrlIncentivos = ConfigurationManager.AppSettings["Incentivos"];
            Globals.UrlLugaresPago = ConfigurationManager.AppSettings["LugaresPago"];
            Globals.UrlMatriz = ConfigurationManager.AppSettings["Matriz"];
            Globals.UrlOfertasNuevas = ConfigurationManager.AppSettings["OfertasNuevas"];
            Globals.UrlRevistaGana = ConfigurationManager.AppSettings["RevistaGana"];
            Globals.UrlEscalaDescuentos = ConfigurationManager.AppSettings["EscalaDescuentos"];
            Globals.UrlOfertasFic = ConfigurationManager.AppSettings["OfertasFic"];
            //2106
            Globals.UrlNavidadConsultora = ConfigurationManager.AppSettings["NavidadConsultora"];
            //**** 1664 Carpetas - Fin    *****//

            // configuración del Dynamic Global Action Filter de Log
            //LogActionFilterProvider providerLog = new LogActionFilterProvider();
            //providerLog.Add("Bienvenida", "Index");
            //providerLog.Add("Login", "Index");
            //providerLog.Add("Catalogo", "Index");
            //providerLog.Add("Cliente", "Index");
            //providerLog.Add("Cliente", "Mantener");
            //providerLog.Add("Bienvenida", "ConsultarFaltantesAnunciados");
            //providerLog.Add("EstadoCuenta", "Index");

            //FilterProviders.Providers.Add(providerLog);

            // configuración del Dynamic Global Action Filter de Expiración de Sesión
            SessionExpiredActionFilterProvider providerSession = new SessionExpiredActionFilterProvider();

            providerSession.Add("ActualizarDatos", "Index");
            providerSession.Add("ActualizarDatos", "Registrar");
            providerSession.Add("ActualizarDatos", "Cancelar");

            providerSession.Add("Banner", "ObtenerCabeceraYFilaConfiguracionSubGrilla");
            providerSession.Add("Banner", "ConsultarGruposPorCampania");
            providerSession.Add("Banner", "Index");
            providerSession.Add("Banner", "ConsultaBannerPorGrupoCampania");
            providerSession.Add("Banner", "InsertarPaisPorBanner");
            providerSession.Add("Banner", "EliminarBanner");
            providerSession.Add("Banner", "ObtenerBannerPaginaPrincipal");

            providerSession.Add("Bienvenida", "Index");
            providerSession.Add("Bienvenida", "ConsultarFaltantesAnunciados");

            providerSession.Add("Catalogo", "Index");
            providerSession.Add("Catalogo", "ConsultarClientes");
            providerSession.Add("Catalogo", "GetCatalogosByCampaniaId");
            providerSession.Add("Catalogo", "ColumnasDeshabilitadasxPais");
            providerSession.Add("Catalogo", "GetEmbedCatalogo");
            providerSession.Add("Catalogo", "EnviarEmail");

            providerSession.Add("Cliente", "Index");
            providerSession.Add("Cliente", "Mantener");
            providerSession.Add("Cliente", "GetCatalogosByCampaniaId");
            providerSession.Add("Cliente", "Consultar");
            providerSession.Add("Cliente", "Eliminar");
            providerSession.Add("Cliente", "DeshacerCambios");

            /* no se han ubicado */
            providerSession.Add("Cliente", "Update");
            providerSession.Add("Cliente", "Insert");
            /* no se han ubicado */

            providerSession.Add("ConfiguracionValidacion", "Index");
            providerSession.Add("ConfiguracionValidacion", "ObtenerConfiguracionPedidosPorPais");
            providerSession.Add("ConfiguracionValidacion", "Mantener");

            providerSession.Add("ConsultaPedido", "ConsultaPedido");
            providerSession.Add("ConsultaPedido", "ConsultarBloqueo");
            providerSession.Add("ConsultaPedido", "BloquearPedido");
            providerSession.Add("ConsultaPedido", "DesbloquearPedido");
            providerSession.Add("ConsultaPedido", "ExportarPDFBloqueo");
            providerSession.Add("ConsultaPedido", "ExportarExcelBloqueo");
            providerSession.Add("ConsultaPedido", "ExportarExcel");
            providerSession.Add("ConsultaPedido", "BloqueoPedido");
            providerSession.Add("ConsultaPedido", "ObtenterDropDownPorPais");
            providerSession.Add("ConsultaPedido", "SelectTerritorioByCodigo");
            providerSession.Add("ConsultaPedido", "SelectConsultoraByCodigo");
            providerSession.Add("ConsultaPedido", "Consultar");
            providerSession.Add("ConsultaPedido", "ExportarPDF");

            providerSession.Add("ConsultoraFicticia", "Index");
            providerSession.Add("ConsultoraFicticia", "ValidarUsuario");
            providerSession.Add("ConsultoraFicticia", "ValidarConsultora");
            providerSession.Add("ConsultoraFicticia", "InsertarConsultoraFicticia");
            providerSession.Add("ConsultoraFicticia", "ActualizarConsultoraFicticia");
            providerSession.Add("ConsultoraFicticia", "ConsultarConsultoraFicticia");
            providerSession.Add("ConsultoraFicticia", "EliminarConsultoraFicticia");

            providerSession.Add("Cronograma", "Index");
            providerSession.Add("Cronograma", "ConsultarLog");
            providerSession.Add("Cronograma", "ObtenterCampanias");
            providerSession.Add("Cronograma", "ActualizarLog");
            providerSession.Add("Cronograma", "ObtenterCampaniasPorPais");
            providerSession.Add("Cronograma", "ConsultarCronogramaAnticipado");
            providerSession.Add("Cronograma", "GetCronogramaByCampaniayZona");
            providerSession.Add("Cronograma", "Update");
            providerSession.Add("Cronograma", "ConsultarCronograma");
            providerSession.Add("Cronograma", "MigrarAnticipado");

            providerSession.Add("DescargaPedidos", "DescargarPedidos");
            providerSession.Add("DescargaPedidos", "RealizarDescarga");

            /* no se esta invocando desde js */
            providerSession.Add("DuplaSAC", "Index");

            providerSession.Add("EstadoCuenta", "Index");
            providerSession.Add("EstadoCuenta", "ConsultarEstadoCuenta");
            providerSession.Add("EstadoCuenta", "EnviarCorreo");
            providerSession.Add("EstadoCuenta", "");
            providerSession.Add("EstadoCuenta", "");
            providerSession.Add("EstadoCuenta", "");

            /* no tiene vista, por que? */
            providerSession.Add("FacturaElectronica", "Index");

            providerSession.Add("FileUpload", "ImageUpload");
            providerSession.Add("FileUpload", "ImageMatrizUpload");

            providerSession.Add("GestionContenido", "Index");
            providerSession.Add("GestionContenido", "ObteneterFormularioDato");
            providerSession.Add("GestionContenido", "ObtenerListaFormularioDatoTelefonos");
            providerSession.Add("GestionContenido", "ObteneterFormularioDatoTerminos");
            providerSession.Add("GestionContenido", "ObteneterFormularioDatoCartas");
            providerSession.Add("GestionContenido", "ObtenerListaFormularioDatoTelefonos");
            providerSession.Add("GestionContenido", "ValidUrl");
            providerSession.Add("GestionContenido", "Eliminar");
            providerSession.Add("GestionContenido", "InsertBelResponde");
            providerSession.Add("GestionContenido", "Mantener");
            providerSession.Add("GestionContenido", "MantenerPoliticas");
            providerSession.Add("GestionContenido", "MantenerContratos");
            providerSession.Add("GestionContenido", "MantenerLugaresdePago");
            providerSession.Add("GestionContenido", "ConsultarLugaresDePago");
            providerSession.Add("GestionContenido", "ConfiguracionFormulariosInformativos");
            providerSession.Add("GestionContenido", "EliminarLugardePago");
            providerSession.Add("GestionContenido", "ObtenterCampaniasPorPais");
            providerSession.Add("GestionContenido", "GetFondoyLogo");

            providerSession.Add("GestionFaltantes", "GestionFaltantes");
            providerSession.Add("GestionFaltantes", "ObtenterCampaniasPorPais");
            providerSession.Add("GestionFaltantes", "SelectZonaByCodigo");
            providerSession.Add("GestionFaltantes", "SelectCodigoProducto");
            providerSession.Add("GestionFaltantes", "Consultar");
            providerSession.Add("GestionFaltantes", "Eliminar");
            providerSession.Add("GestionFaltantes", "Insertar");
            providerSession.Add("GestionFaltantes", "DescargaModelo");

            providerSession.Add("MatrizCampania", "Actualizarmatrizcampania");
            providerSession.Add("MatrizCampania", "CargarCampania");
            providerSession.Add("MatrizCampania", "ConsultarDescripcion");
            providerSession.Add("MatrizCampania", "InsertarProductoDescripcion");

            providerSession.Add("MisDatos", "Index");
            providerSession.Add("MisDatos", "CambiarContrasenia");
            providerSession.Add("MisDatos", "ActualizarDatos");

            providerSession.Add("Pedido", "Index");
            providerSession.Add("Pedido", "AutocompleteByProductoCUV");
            providerSession.Add("Pedido", "AutocompleteByProductoDescripcion");
            providerSession.Add("Pedido", "AutocompleteByCliente");
            providerSession.Add("Pedido", "ActualizarMasivo");
            providerSession.Add("Pedido", "DeleteAll");
            providerSession.Add("Pedido", "AutocompleteByClienteListado");
            providerSession.Add("Pedido", "FindByCUV");
            providerSession.Add("Pedido", "Update");
            providerSession.Add("Pedido", "RegistrarCliente");
            providerSession.Add("Pedido", "PedidoReservado");
            providerSession.Add("Pedido", "PedidoReservadoExportarPdf");
            providerSession.Add("Pedido", "PedidoReservadoEnviarCorreo");
            providerSession.Add("Pedido", "PedidoReservadoDeshacerReserva");
            providerSession.Add("Pedido", "InsertarDesglose");

            providerSession.Add("PedidoWebAnteriores", "PedidoWebAnteriores");
            providerSession.Add("PedidoWebAnteriores", "ConsultarPedidoWebAnteriores");
            providerSession.Add("PedidoWebAnteriores", "PedidoWebAnterioresDetalle");
            providerSession.Add("PedidoWebAnteriores", "ConsultarPedidoWebAnterioresProductos");

            providerSession.Add("PedidoWeb", "PedidoWeb");
            providerSession.Add("PedidoWeb", "ConsultarPedidoWeb");
            providerSession.Add("PedidoWeb", "PedidoWebDetalle");
            providerSession.Add("PedidoWeb", "ConsultarPedidoWebDetalleClientes");
            providerSession.Add("PedidoWeb", "ConsultarPedidoWebDetalleProductos");
            providerSession.Add("PedidoWeb", "EnviarEmail");

            providerSession.Add("Percepciones", "Index");
            providerSession.Add("Percepciones", "PercepcionDetalle");
            providerSession.Add("Percepciones", "Consultar");
            providerSession.Add("Percepciones", "ConsultarDetalle");
            providerSession.Add("Percepciones", "GetDatosBelcorp");

            providerSession.Add("ReportePedidoCampania", "Index");
            providerSession.Add("ReportePedidoCampania", "ObtenterCampaniasyRegionesPorPais");
            providerSession.Add("ReportePedidoCampania", "GetConsultorasIds");
            providerSession.Add("ReportePedidoCampania", "ObtenerZonasByRegion");
            providerSession.Add("ReportePedidoCampania", "ExportarPDF");
            providerSession.Add("ReportePedidoCampania", "ConsultarPedidoCampania");
            providerSession.Add("ReportePedidoCampania", "ExportarExcel");
            providerSession.Add("ReportePedidoCampania", "ConsultarPedidoCampania");

            providerSession.Add("ReportePedidoDDWeb", "ReportePedidosDDWeb");
            providerSession.Add("ReportePedidoDDWeb", "ObtenterCampaniasyZonasPorPais");
            providerSession.Add("ReportePedidoDDWeb", "SelectConsultora");
            providerSession.Add("ReportePedidoDDWeb", "ExportarExcelCabecera");
            providerSession.Add("ReportePedidoDDWeb", "ConsultarPedidosDDWeb");
            providerSession.Add("ReportePedidoDDWeb", "ReportePedidosDDWebDetalle");
            providerSession.Add("ReportePedidoDDWeb", "ExportarPDF");
            providerSession.Add("ReportePedidoDDWeb", "ExportarExcel");
            providerSession.Add("ReportePedidoDDWeb", "ConsultarPedidosDDWebDetalle");

            providerSession.Add("Rol", "Rol");
            providerSession.Add("Rol", "Mantener");
            providerSession.Add("Rol", "InsertarPermiso");
            providerSession.Add("Rol", "Consultar");
            providerSession.Add("Rol", "Eliminar");
            providerSession.Add("Rol", "CargarPermiso");

            /* no tiene vista, es una redireccion */
            providerSession.Add("Superate", "Index");

            providerSession.Add("UpdatePassSAC", "Index");
            providerSession.Add("UpdatePassSAC", "ResetPassConsultora");
            providerSession.Add("UpdatePassSAC", "Consultar");
            providerSession.Add("UpdatePassSAC", "CambiarPass");

            providerSession.Add("UsuarioRol", "Index");
            providerSession.Add("UsuarioRol", "ValidarUsuario");
            providerSession.Add("UsuarioRol", "InsertarUsuarioRol");
            providerSession.Add("UsuarioRol", "ConsultarUsuarioRol");
            providerSession.Add("UsuarioRol", "EliminarUsuarioRol");

            providerSession.Add("AdministrarFactoresGanancia", "Index");
            providerSession.Add("AdministrarFactoresGanancia", "Consultar");
            providerSession.Add("AdministrarFactoresGanancia", "Mantener");
            providerSession.Add("AdministrarFactoresGanancia", "Insertar");
            providerSession.Add("AdministrarFactoresGanancia", "Actualizar");
            providerSession.Add("AdministrarFactoresGanancia", "Eliminar");

            providerSession.Add("Servicios", "AdministrarServicios");
            providerSession.Add("Servicios", "MantenimientoServicios");
            providerSession.Add("Servicios", "RedireccionServicio");
            providerSession.Add("Servicios", "Mantener");
            providerSession.Add("Servicios", "Update");
            providerSession.Add("Servicios", "Insert");
            providerSession.Add("Servicios", "InsertParametro");
            providerSession.Add("Servicios", "Delete");
            providerSession.Add("Servicios", "DeleteServicioParametro");
            providerSession.Add("Servicios", "MantenerEstado");
            providerSession.Add("Servicios", "DeleteEstado");
            providerSession.Add("Servicios", "InsertEstado");
            providerSession.Add("Servicios", "ConsultarServicios");
            providerSession.Add("Servicios", "ConsultarParametrosbyServicios");
            providerSession.Add("Servicios", "ConsultarEstadoServiciobyPais");

            /*Ofertas Web y Liquidación */
            providerSession.Add("OfertaWeb", "OfertasWeb");
            providerSession.Add("OfertaWeb", "InsertOfertaWebPortal");
            providerSession.Add("OfertaWeb", "UpdateOfertaWebPortal");
            providerSession.Add("OfertaWeb", "AdministrarOfertas");
            providerSession.Add("OfertaWeb", "ObtenerImagenesByCodigoSAP");
            providerSession.Add("OfertaWeb", "ObtenterCampaniasPorPais");
            providerSession.Add("OfertaWeb", "ConsultarOfertaWeb");
            providerSession.Add("OfertaWeb", "InsertOfertaWeb");
            providerSession.Add("OfertaWeb", "ObtenerOrdenPriorizacion");
            providerSession.Add("OfertaWeb", "ValidarPriorizacion");
            providerSession.Add("OfertaWeb", "UpdateOfertaWeb");
            providerSession.Add("OfertaWeb", "DeshabilitarOfertaWeb");
            providerSession.Add("OfertaWeb", "ActualizarStockMasivo");

            providerSession.Add("OfertaLiquidacion", "OfertasLiquidacion");
            providerSession.Add("OfertaLiquidacion", "InsertOfertaWebPortal");
            providerSession.Add("OfertaLiquidacion", "UpdateOfertaWebPortal");
            providerSession.Add("OfertaLiquidacion", "ObtenerStockActualProducto");
            providerSession.Add("OfertaLiquidacion", "ObtenerUnidadesPermitidasProducto");
            providerSession.Add("OfertaLiquidacion", "AdministrarOfertasLiquidacion");
            providerSession.Add("OfertaLiquidacion", "ObtenerDatosAdministracionCorreo");
            providerSession.Add("OfertaLiquidacion", "ObtenterCampaniasPorPais");
            providerSession.Add("OfertaLiquidacion", "ObtenerImagenesByCodigoSAP");
            providerSession.Add("OfertaLiquidacion", "ObtenerOrdenPriorizacion");
            providerSession.Add("OfertaLiquidacion", "ValidarPriorizacion");
            providerSession.Add("OfertaLiquidacion", "ConsultarOfertaLiquidacion");
            providerSession.Add("OfertaLiquidacion", "InsertOfertaWeb");
            providerSession.Add("OfertaLiquidacion", "UpdateOfertaWeb");
            providerSession.Add("OfertaLiquidacion", "DeshabilitarOfertaWeb");
            providerSession.Add("OfertaLiquidacion", "ActualizarStockMasivo");
            providerSession.Add("OfertaLiquidacion", "AdministrarCorreosOferta");

            providerSession.Add("MatrizComercial", "AdministrarMatrizComercial");
            providerSession.Add("MatrizComercial", "ConsultarMatrizComercial");
            providerSession.Add("MatrizComercial", "InsertMatrizComercial");
            providerSession.Add("MatrizComercial", "ObtenerISOPais");
            providerSession.Add("MatrizComercial", "UpdateMatrizComercial");

            //Web Mobile
            providerSession.Add("Bienvenida", "Index", "Mobile");
            providerSession.Add("Catalogo", "Index", "Mobile");
            providerSession.Add("EstadoCuenta", "Index", "Mobile");
            providerSession.Add("NovedadesCampania", "Index", "Mobile");
            providerSession.Add("Menu", "Ver", "Mobile");
            providerSession.Add("Notificaciones", "Index", "Mobile");
            providerSession.Add("Notificaciones", "DetalleSolicitudCliente", "Mobile");
            providerSession.Add("Notificaciones", "ListarObservaciones", "Mobile");
            providerSession.Add("Notificaciones", "ListarObservacionesStock", "Mobile");
			providerSession.Add("Notificaciones", "DetalleSolicitudClienteCatalogo", "Mobile");
            providerSession.Add("OfertaLiquidacion", "Index", "Mobile");
            providerSession.Add("PedidoCliente", "Index", "Mobile");
            providerSession.Add("Pedido", "Index", "Mobile");
            providerSession.Add("Pedido", "Detalle", "Mobile");
            providerSession.Add("Pedido", "Validado", "Mobile");
            providerSession.Add("Pedido", "CampaniaZonaNoConfigurada", "Mobile");
            providerSession.Add("PedidosFacturados", "Index", "Mobile");
            providerSession.Add("ProductosAgotados", "Index", "Mobile");
            providerSession.Add("ProductosDestacados", "Index", "Mobile");
            providerSession.Add("Revista", "Index", "Mobile");
            providerSession.Add("SeguimientoPedido", "Index", "Mobile");
            providerSession.Add("Cliente", "Index", "Mobile");
			providerSession.Add("Paypal", "Index", "Mobile");
            providerSession.Add("ConsultoraOnline", "Index", "Mobile");
            providerSession.Add("ConsultoraOnline", "Informacion", "Mobile");
            providerSession.Add("ConsultoraOnline", "Inscripcion", "Mobile");
            providerSession.Add("ConsultoraOnline", "Afiliar", "Mobile");
            providerSession.Add("ConsultoraOnline", "MisPedidos", "Mobile");
            providerSession.Add("ConsultoraOnline", "DetallePedido", "Mobile");
            providerSession.Add("ConsultoraOnline", "MiPerfil", "Mobile");

            /*ShowRoom*/
            providerSession.Add("ShowRoom", "AdministrarShowRoom");

            FilterProviders.Providers.Add(providerSession);

            AutoMapperConfiguration.Configure();
        }


        protected void Application_EndRequest()
        {
            //var context = new HttpContextWrapper(Context);

            //if (Context.Response.StatusCode == 302 && context.Request.IsAjaxRequest())
            //{
            //    Context.Response.Clear();
            //    Context.Response.StatusCode = 401;
            //}
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        private void Application_BeginRequest(object sender, EventArgs e)
        {
            if (String.Compare(Request.Path, Request.ApplicationPath, StringComparison.InvariantCultureIgnoreCase) == 0
                && !(Request.Path.EndsWith("/")))
                Response.Redirect(Request.Path + "/");
        }

        //void OnServiceConfigurationCreated(object sender, FederationConfigurationCreatedEventArgs e) 
        //{ 
        //    var sessionTransforms = new List<CookieTransform>(
        //        new CookieTransform[] { new DeflateCookieTransform(), 
        //            new RsaEncryptionCookieTransform(e.FederationConfiguration.ServiceCertificate), 
        //            new RsaSignatureCookieTransform(e.FederationConfiguration.ServiceCertificate) }); 
        //    var sessionHandler = new SessionSecurityTokenHandler(sessionTransforms.AsReadOnly()); 
        //    e.FederationConfiguration.IdentityConfiguration.SecurityTokenHandlers.AddOrReplace(sessionHandler); 
        //}

        //protected void Application_Error(object sender, EventArgs e)
        //{
        //    var httpContext = ((MvcApplication)sender).Context;

        //    var currentRouteData = RouteTable.Routes.GetRouteData(new HttpContextWrapper(httpContext));
        //    var currentController = " ";
        //    var currentAction = " ";

        //    // obtiene de routing la controladora y accion donde ocurrio el error
        //    if (currentRouteData != null)
        //    {
        //        if (currentRouteData.Values["controller"] != null && !String.IsNullOrEmpty(currentRouteData.Values["controller"].ToString()))
        //        {
        //            currentController = currentRouteData.Values["controller"].ToString();
        //        }

        //        if (currentRouteData.Values["action"] != null && !String.IsNullOrEmpty(currentRouteData.Values["action"].ToString()))
        //        {
        //            currentAction = currentRouteData.Values["action"].ToString();
        //        }
        //    }

        //    var ex = Server.GetLastError();

        //    // crea la controladora dinamicamente
        //    var controller = new ErrorController();
        //    var routeData = new RouteData();
        //    var action = "Index";

        //    if (ex is HttpException)
        //    {
        //        var httpEx = ex as HttpException;

        //        switch (httpEx.GetHttpCode())
        //        {
        //            case 404:
        //                action = "NotFound";
        //                break;

        //            // otros errores Http

        //            default:
        //                action = "Index";
        //                break;
        //        }
        //    }

        //    // se deriva a la controladora de errores Http y las Views correspondientes
        //    httpContext.ClearError();
        //    httpContext.Response.Clear();
        //    httpContext.Response.StatusCode = ex is HttpException ? ((HttpException)ex).GetHttpCode() : 500;
        //    httpContext.Response.TrySkipIisCustomErrors = true;
        //    routeData.Values["controller"] = "Error";
        //    routeData.Values["action"] = action;

        //    controller.ViewData.Model = new HandleErrorInfo(ex, currentController, currentAction);
        //    ((IController)controller).Execute(new RequestContext(new HttpContextWrapper(httpContext), routeData));
        //} 

    }
}
