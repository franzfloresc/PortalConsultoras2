﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceOferta;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Text;
using BEEstrategia = Portal.Consultoras.Web.ServicePedido.BEEstrategia;

/*
CONTROL DE CAMBIOS
CORRELATIVO -   PERSONA -   FECHA       -   MOTIVO
@001        -   FSV     -   08/06/2018  -   Se traslada llamamientos de ShowRoom y ODD al nuevo servicio unificado "OfertaService".
@002
*/

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseShowRoomController : BaseEstrategiaController
    {
        protected string CodigoProceso
        {
            get { return ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.EmailCodigoProceso]; }
        }

        protected void ActionExecutingMobile()
        {
            if (sessionManager.GetUserData() == null) return;

            var userData = UserData();
            ViewBag.CodigoCampania = userData.CampaniaID.ToString();

            try
            {
                ViewBag.EsMobile = 2;
                BuildMenuMobile(userData, revistaDigital);
                CargarValoresGenerales(userData);

                bool mostrarBanner, permitirCerrarBanner = false;
                if (SiempreMostrarBannerPL20()) mostrarBanner = true;
                else if (NuncaMostrarBannerPL20()) mostrarBanner = false;
                else
                {
                    mostrarBanner = true;
                    permitirCerrarBanner = true;

                    if (userData.CloseBannerPL20) mostrarBanner = false;
                    else
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            var result = sv.ValidacionModificarPedidoSelectiva(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA, false, true, false);
                            if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado) mostrarBanner = false;
                        }
                    }
                }

                bool mostrarBannerTop = !NuncaMostrarBannerTopPL20();
                ViewBag.MostrarBannerTopPL20 = mostrarBannerTop;

                if (mostrarBanner || mostrarBannerTop)
                {
                    ViewBag.PermitirCerrarBannerPL20 = permitirCerrarBanner;
                    ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                    ViewBag.ShowRoomBannerLateral = showRoomBannerLateral;
                    ViewBag.MostrarShowRoomBannerLateral = sessionManager.GetEsShowRoom() &&
                        !showRoomBannerLateral.ConsultoraNoEncontrada && !showRoomBannerLateral.ConsultoraNoEncontrada &&
                        showRoomBannerLateral.BEShowRoomConsultora.EventoConsultoraID != 0 && showRoomBannerLateral.EstaActivoLateral;

                    if (showRoomBannerLateral.DiasFalta < 1)
                    {
                        ViewBag.MostrarShowRoomBannerLateral = false;
                    }

                    if (showRoomBannerLateral.DiasFalta > 0)
                    {
                        if (showRoomBannerLateral.DiasFalta > 1)
                        {
                            showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍAS";
                        }
                        else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍA"; }
                    }

                    ViewBag.ImagenPopupShowroomIntriga = showRoomBannerLateral.ImagenPopupShowroomIntriga;
                    ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                    ViewBag.ImagenPopupShowroomVenta = showRoomBannerLateral.ImagenPopupShowroomVenta;
                    ViewBag.ImagenBannerShowroomVenta = showRoomBannerLateral.ImagenBannerShowroomVenta;
                    ViewBag.DiasFaltantesLetras = showRoomBannerLateral.LetrasDias;

                    OfertaDelDiaModel ofertaDelDia = GetOfertaDelDiaModel();
                    ViewBag.OfertaDelDia = ofertaDelDia;

                    ViewBag.MostrarOfertaDelDia =
                        !userData.CloseOfertaDelDia
                        && userData.TieneOfertaDelDia
                        && ofertaDelDia != null
                        && ofertaDelDia.TeQuedan.TotalSeconds > 0;

                    showRoomBannerLateral.EstadoActivo = mostrarBannerTop ? "0" : "1";
                }
                ViewBag.MostrarBannerPL20 = mostrarBanner;
                ViewBag.MostrarBannerOtros = mostrarBannerTop;

                ViewBag.EstadoActivo = mostrarBannerTop ? "0" : "1";

                if (mostrarBanner
                    && !(
                            (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2)
                            || userData.IndicadorGPRSB == 0
                        )
                )
                {
                    ViewBag.MostrarBannerPL20 = false;
                    ViewBag.MostrarOfertaDelDia = false;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        protected bool GetEventoConsultoraRecibido(UsuarioModel usuario)
        {
            var result = false;

            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetEventoConsultoraRecibido(usuario.PaisID, usuario.CodigoConsultora, usuario.CampaniaID);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "BaseShowRoomController.GetEventoConsultoraRecibido");
            }


            return result;
        }

        public bool ValidarIngresoShowRoom(bool esIntriga)
        {
            if (!configEstrategiaSR.CargoEntidadesShowRoom)
                return false;

            var resultado = false;

            var esShowRoom = sessionManager.GetEsShowRoom();
            var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
            var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

            if (esIntriga)
            {
                resultado = esShowRoom && !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }

            if (!esIntriga)
            {
                resultado = esShowRoom && mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }

            return resultado;
        }

        public ShowRoomEventoModel CargarValoresModel()
        {
            ShowRoomEventoModel showRoomEventoModel;

            try
            {
                var showRoomEvento = configEstrategiaSR.BeShowRoom;
                var codigoConsultora = userData.CodigoConsultora;

                showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                showRoomEventoModel.Simbolo = userData.Simbolo;
                showRoomEventoModel.CodigoIso = userData.CodigoISO;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                var listaShowRoomOferta = ObtenerListaProductoShowRoom(userData.CampaniaID, codigoConsultora, esFacturacion);
                showRoomEventoModel.ListaShowRoomOferta = listaShowRoomOferta;

                var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, showRoomEventoModel.EventoID, showRoomEventoModel.CampaniaID);
                showRoomEventoModel.ListaShowRoomCompraPorCompra = listaCompraPorCompra;

                var listaCategoria = new List<ShowRoomCategoriaModel>();
                var categorias = listaShowRoomOferta.GroupBy(p => p.CodigoCategoria).Select(p => p.First());
                foreach (var item in categorias)
                {
                    if (!string.IsNullOrEmpty(item.DescripcionCategoria))
                    {
                        var beCategoria = new ShowRoomCategoriaModel
                        {
                            Codigo = item.CodigoCategoria,
                            Descripcion = item.DescripcionCategoria,
                            EventoID = showRoomEventoModel.EventoID
                        };
                        listaCategoria.Add(beCategoria);
                    }
                }

                listaCategoria = listaCategoria.OrderBy(p => p.Descripcion).ToList();

                showRoomEventoModel.ListaCategoria = listaCategoria;

                var tipoAplicacion = GetIsMobileDevice() ? Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                    : Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;

                showRoomEventoModel.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones, tipoAplicacion);
                showRoomEventoModel.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
                showRoomEventoModel.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);

                if (GetIsMobileDevice())
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                }
                else
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ImagenFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoContenidoOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoContenidoOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoBotonVerMasOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoBotonVerMasOfertaSubCampania, tipoAplicacion);

                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                showRoomEventoModel = new ShowRoomEventoModel();
            }

            return showRoomEventoModel;
        }

        protected virtual bool GetIsMobileDevice()
        {
            return Request.Browser.IsMobileDevice;
        }

        protected void UpdShowRoomEventoConsultoraEmailRecibido(string codigoConsultoraFromQueryString, int campaniaIdFromQueryString, UsuarioModel usuario)
        {
            try
            {
                //@001 FSV INICIO
                //var entidad = new BEShowRoomEventoConsultora
                var entidad = new ServicePedido.BEShowRoomEventoConsultora
                //@001 FSV FIN
                {
                    CodigoConsultora = codigoConsultoraFromQueryString,
                    CampaniaID = campaniaIdFromQueryString
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdShowRoomEventoConsultoraEmailRecibido(usuario.PaisID, entidad);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "BaseShowRoomController.GetEventoConsultoraRecibido");
            }
        }

        protected class ShowRoomQueryStringValidator
        {
            private readonly int CODIGO_PROCESO_INDEX = 0;
            private readonly int CODIGO_ISO_INDEX = 1;
            private readonly int CODIGO_CONSULTORA_INDEX = 2;
            private readonly int CAMPANIA_ID_INDEX = 3;
            private readonly int OFERTA_ID_INDEX = 5;
            private readonly char SEPARATOR = ';';
            private string QueryString { get; set; }

            public ShowRoomQueryStringValidator(string queryString)
            {
                if (!string.IsNullOrEmpty(queryString))
                {
                    LoadParameterValuesFromQueryString(queryString);
                }
            }

            private void LoadParameterValuesFromQueryString(string queryString)
            {
                QueryString = Util.Decrypt(queryString);
                var paramValues = QueryString.Split(SEPARATOR);
                if (CODIGO_PROCESO_INDEX < paramValues.Length) CodigoProceso = paramValues[CODIGO_PROCESO_INDEX];
                if (CODIGO_ISO_INDEX < paramValues.Length) CodigoIso = paramValues[CODIGO_ISO_INDEX];
                if (CODIGO_CONSULTORA_INDEX < paramValues.Length) CodigoConsultora = paramValues[CODIGO_CONSULTORA_INDEX];
                if (CAMPANIA_ID_INDEX < paramValues.Length && !string.IsNullOrEmpty(paramValues[CAMPANIA_ID_INDEX]))
                    CampanaId = Convert.ToInt32(paramValues[CAMPANIA_ID_INDEX]);

                if (OFERTA_ID_INDEX < paramValues.Length &&
                    !string.IsNullOrEmpty(paramValues[OFERTA_ID_INDEX]))
                    OfertaId = Convert.ToInt32(paramValues[OFERTA_ID_INDEX]);
            }

            public string CodigoProceso { get; private set; }
            public string CodigoIso { get; private set; }
            public string CodigoConsultora { get; private set; }
            public int CampanaId { get; private set; }
            public int OfertaId { get; private set; }
        }

        protected virtual List<TablaLogicaDatosModel> GetTablaLogicaDatos(short tablaLogicaId)
        {
            List<BETablaLogicaDatos> tablaLogicaDatos;

            using (var svc = new SACServiceClient())
            {
                tablaLogicaDatos = svc.GetTablaLogicaDatos(userData.PaisID, tablaLogicaId).ToList();
            }

            var tablaLogicaDatosModel = Mapper.Map<List<BETablaLogicaDatos>, List<TablaLogicaDatosModel>>(tablaLogicaDatos);

            return tablaLogicaDatosModel;
        }

        protected virtual string ObtenerCarpetaPais()
        {
            return Globals.UrlMatriz + "/" + userData.CodigoISO;
        }

        public EstrategiaPedidoModel ViewDetalleOferta(int id)
        {
            var modelo = GetOfertaConDetalle(id);
            modelo.CodigoISO = userData.CodigoISO;
            modelo.ListaOfertaShowRoom = GetOfertaListadoExcepto(id);
            var listaDetalle = ObtenerPedidoWebDetalle();
            modelo.ListaOfertaShowRoom.Update(o => o.Agregado = (listaDetalle.Find(p => p.CUV == o.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none");

            modelo.FBMensaje = "";

            var tipoAplicacion = GetIsMobileDevice() ? Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                    : Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;

            modelo.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
            modelo.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);

            return modelo;
        }

        public EstrategiaPedidoModel GetOfertaConDetalle(int idOferta)
        {
            EstrategiaPedidoModel ofertaShowRoomModelo = new EstrategiaPedidoModel();
            if (idOferta <= 0) return ofertaShowRoomModelo;

            List<EstrategiaPedidoModel> listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);
            ofertaShowRoomModelo = listadoOfertasTodasModel.Find(o => o.OfertaShowRoomID == idOferta) ?? new EstrategiaPedidoModel();
            if (ofertaShowRoomModelo.OfertaShowRoomID <= 0) return ofertaShowRoomModelo;

            ofertaShowRoomModelo.ImagenProducto = Util.Trim(ofertaShowRoomModelo.ImagenProducto);
            ofertaShowRoomModelo.ImagenProducto = ofertaShowRoomModelo.ImagenProducto == "" ?
                "/Content/Images/showroom/no_disponible.png" :
                ofertaShowRoomModelo.ImagenProducto;

            /*TONOS-INI*/
            #region Obtener productos por estrategia
            List<BEEstrategiaProducto> listaEstrategiaProducto = new List<BEEstrategiaProducto>();
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                BEEstrategia estrategia = new BEEstrategia() { PaisID = userData.PaisID, EstrategiaID = idOferta };
                listaEstrategiaProducto = svc.GetEstrategiaProducto(estrategia).ToList();
            }

            // filtrar solo activos
            listaEstrategiaProducto = listaEstrategiaProducto.Where(x => x.Activo == 1).ToList();
            string codigoVariante = listaEstrategiaProducto.Select(o => o.CodigoEstrategia).FirstOrDefault();
            #endregion

            #region Obtener tonos de AppCatalogo por codigosap
            StringBuilder listaCodigosSAP = new StringBuilder();
            const string separador = "|";
            listaCodigosSAP.Append(separador);

            if (codigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos || codigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija)
            {
                foreach (BEEstrategiaProducto producto in listaEstrategiaProducto.Where(producto => producto != null && string.IsNullOrEmpty(producto.ImagenProducto) == true))
                {
                    producto.SAP = Util.Trim(producto.SAP);
                    if (producto.SAP != string.Empty && !listaCodigosSAP.ToString().Contains(separador + producto.SAP + separador))
                    {
                        listaCodigosSAP.Append(producto.SAP + separador);
                    }
                }
            }
            else if (codigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
            {
                foreach (BEEstrategiaProducto producto in listaEstrategiaProducto.Where(producto => producto != null))
                {
                    producto.SAP = Util.Trim(producto.SAP);
                    if (producto.SAP != string.Empty && !listaCodigosSAP.ToString().Contains(separador + producto.SAP + separador))
                    {
                        listaCodigosSAP.Append(producto.SAP + separador);
                    }
                }
            }

            List<Producto> listaAppCatalogo = new List<Producto>();
            if (listaCodigosSAP.ToString() != separador)
            {
                string listaDeCUV = listaCodigosSAP.ToString().Substring(1, listaCodigosSAP.ToString().Length - 2);
                int numeroCampanias = Convert.ToInt32(GetConfiguracionManager(Constantes.ConfiguracionManager.NumeroCampanias));
                using (ProductoServiceClient svc = new ProductoServiceClient())
                {
                    listaAppCatalogo = svc.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, userData.CampaniaID, listaDeCUV, numeroCampanias).ToList();
                }
            }
            #endregion

            #region Algoritmo para relacionar productos con tonos
            List<ProductoModel> listaInfoAppCatalogo = Mapper.Map<List<Producto>, List<ProductoModel>>(listaAppCatalogo);
            foreach (ProductoModel producto in listaInfoAppCatalogo)
            {
                BEEstrategiaProducto estrategiaProducto = listaEstrategiaProducto.FirstOrDefault(p => p.CUV == producto.CUV);
                if (estrategiaProducto == null) continue;
                producto.Digitable = estrategiaProducto.Digitable;
            }

            List<ProductoModel> listaProductoTemporal = new List<ProductoModel>();

            if (codigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos || codigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija)
            {
                foreach (BEEstrategiaProducto item in listaEstrategiaProducto)
                {
                    string imagenProducto = string.Empty;
                    if (!string.IsNullOrEmpty(item.ImagenProducto))
                    {
                        imagenProducto = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, item.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO);
                    }
                    else
                    {
                        foreach (ProductoModel app in listaInfoAppCatalogo)
                        {
                            if (app.CodigoProducto == item.SAP)
                            {
                                imagenProducto = app.Imagen;
                            }
                        }
                    }

                    ProductoModel prod = new ProductoModel()
                    {
                        NombreComercial = item.NombreProducto,
                        Descripcion = item.Descripcion1,
                        Imagen = imagenProducto,
                        DescripcionMarca = item.NombreMarca,
                        Orden = item.Orden,
                        Grupo = item.Grupo,
                        PrecioCatalogo = item.Precio,
                        PrecioCatalogoString = Util.DecimalToStringFormat(item.Precio, userData.CodigoISO),
                        Digitable = item.Digitable,
                        CUV = Util.Trim(item.CUV),
                        Cantidad = item.Cantidad,
                        FactorCuadre = item.FactorCuadre > 0 ? item.FactorCuadre : 1
                    };
                    listaProductoTemporal.Add(prod);
                }

                listaProductoTemporal.ForEach(h => { h.Digitable = 0; h.NombreComercial = Util.Trim(h.NombreComercial); });
                listaProductoTemporal = listaProductoTemporal.Where(h => h.NombreComercial != "").ToList();
            }
            else if (codigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
            {
                listaEstrategiaProducto = listaEstrategiaProducto.OrderBy(p => p.Grupo).ToList();
                listaInfoAppCatalogo = listaInfoAppCatalogo.OrderBy(p => p.CodigoProducto).ToList();
                int idPk = 1;
                listaInfoAppCatalogo.ForEach(h => h.ID = idPk++);
                idPk = 0;

                foreach (BEEstrategiaProducto item in listaEstrategiaProducto)
                {
                    ProductoModel prod = (ProductoModel)(listaInfoAppCatalogo.FirstOrDefault(p => item.SAP == p.CodigoProducto) ?? new ProductoModel()).Clone();
                    if (Util.Trim(prod.CodigoProducto) == "") continue;
                    if (listaInfoAppCatalogo.Count(p => item.SAP == p.CodigoProducto) > 1)
                    {
                        prod = (ProductoModel)(listaInfoAppCatalogo.FirstOrDefault(p => item.SAP == p.CodigoProducto && p.ID > idPk) ?? new ProductoModel()).Clone();
                    }
                    prod.NombreComercial = item.NombreProducto;
                    prod.Descripcion = item.Descripcion1;
                    if (!string.IsNullOrEmpty(item.ImagenProducto))
                    {
                        prod.Imagen = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, item.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO);
                    }
                    if (!string.IsNullOrEmpty(item.NombreMarca))
                    {
                        prod.DescripcionMarca = item.NombreMarca;
                    }
                    prod.Orden = item.Orden;
                    prod.Grupo = item.Grupo;
                    prod.PrecioCatalogo = item.Precio;
                    prod.PrecioCatalogoString = Util.DecimalToStringFormat(item.Precio, userData.CodigoISO);
                    prod.Digitable = item.Digitable;
                    prod.CUV = Util.Trim(item.CUV);
                    prod.Cantidad = item.Cantidad;
                    prod.FactorCuadre = item.FactorCuadre > 0 ? item.FactorCuadre : 1;
                    listaProductoTemporal.Add(prod);
                    idPk = prod.ID;
                }

                List<ProductoModel> listaHermanosR = new List<ProductoModel>();
                foreach (ProductoModel hermano in listaProductoTemporal.Select(item => (ProductoModel)item.Clone()))
                {
                    hermano.Hermanos = new List<ProductoModel>();
                    if (hermano.Digitable == 1)
                    {
                        bool existe = false;
                        foreach (ProductoModel itemR in listaHermanosR)
                        {
                            existe = itemR.Hermanos.Any(h => h.CUV == hermano.CUV);
                            if (existe) break;
                        }
                        if (existe) continue;

                        hermano.Hermanos = listaProductoTemporal.Where(p => p.Grupo == hermano.Grupo).OrderBy(p => p.Orden).ToList();
                    }
                    listaHermanosR.Add(hermano);
                }
                listaProductoTemporal = listaHermanosR.OrderBy(p => p.Orden).ToList();
            }

            listaInfoAppCatalogo = listaProductoTemporal;

            #endregion
            #region Algoritmo para considerar FactorCuadre
            List<ProductoModel> listaProductoConFactorCuadre = new List<ProductoModel>();
            foreach (ProductoModel infoAppCatalogo in listaInfoAppCatalogo)
            {
                listaProductoConFactorCuadre.Add((ProductoModel)infoAppCatalogo.Clone());
                if (infoAppCatalogo.FactorCuadre <= 1) continue;
                for (int i = 0; i < infoAppCatalogo.FactorCuadre - 1; i++)
                {
                    listaProductoConFactorCuadre.Add((ProductoModel)infoAppCatalogo.Clone());
                }
            }
            #endregion

            ofertaShowRoomModelo.ProductoTonos = listaProductoConFactorCuadre;
            ofertaShowRoomModelo.CodigoEstrategia = codigoVariante;
            /*TONOS-FIN*/

            return ofertaShowRoomModelo;
        }

        public List<EstrategiaPedidoModel> GetOfertaListadoExcepto(int idOferta)
        {
            ShowRoomOfertaModel ofertaShowRoomModelo = new ShowRoomOfertaModel();
            if (idOferta <= 0) return ofertaShowRoomModelo;

            List<ShowRoomOfertaModel> listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);
            ofertaShowRoomModelo = listadoOfertasTodasModel.Find(o => o.OfertaShowRoomID == idOferta) ?? new ShowRoomOfertaModel();
            if (ofertaShowRoomModelo.OfertaShowRoomID <= 0) return ofertaShowRoomModelo;

            ofertaShowRoomModelo.ImagenProducto = Util.Trim(ofertaShowRoomModelo.ImagenProducto);
            ofertaShowRoomModelo.ImagenProducto = ofertaShowRoomModelo.ImagenProducto == "" ?
                "/Content/Images/showroom/no_disponible.png" :
                ofertaShowRoomModelo.ImagenProducto;

            EstrategiaPersonalizadaProductoModel estrategiaModelo = new EstrategiaPersonalizadaProductoModel
            {
                EstrategiaID = idOferta,
                CampaniaID = userData.CampaniaID,
                CodigoVariante = ofertaShowRoomModelo.CodigoEstrategia
            };

            var listaHermanos = GetListaHermanos(estrategiaModelo);
            ofertaShowRoomModelo.ProductoTonos = listaHermanos;
            ofertaShowRoomModelo.CodigoEstrategia = ofertaShowRoomModelo.CodigoEstrategia;

            return ofertaShowRoomModelo;
        }
        {
            var listaOferta = new List<EstrategiaPedidoModel>();
            if (idOferta <= 0) return listaOferta;

            var listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);
            listaOferta = listadoOfertasTodasModel.Where(o => o.OfertaShowRoomID != idOferta).ToList();
            return listaOferta;
        }

        public List<EstrategiaPedidoModel> ObtenerListaProductoShowRoom(int campaniaId, string codigoConsultora, bool esFacturacion = false, bool conFiltroMdo = true)
        {
            var listaDetalle = ObtenerPedidoWebDetalle();

            if (Session[Constantes.ConstSession.ListaProductoShowRoom] != null)
            {
                List<EstrategiaPedidoModel> listadoOfertasTodasModel = ObtenerListaProductoShowRoomSession(listaDetalle);
                return listadoOfertasTodasModel;
            }

            var listaShowRoomOferta = ObtenerListaProductoShowRoomService(campaniaId, codigoConsultora);
            if (conFiltroMdo)
                listaShowRoomOferta = ObtenerListaProductoShowRoomMdo(listaShowRoomOferta, Constantes.FlagRevista.Valor0);

            var listadoOfertasTodasModel1 = ObtenerListaProductoShowRoomFormato(listaShowRoomOferta, listaDetalle, esFacturacion);

            return listadoOfertasTodasModel1;
        }

        public List<EstrategiaPedidoModel> GetProductosCompraPorCompra(bool esFacturacion, int eventoId, int campaniaId)
        {
            try
            {
                if (Session[Constantes.ConstSession.ListaProductoShowRoomCpc] != null)
                {
                    var listadoOfertasTodas = (List<ServiceOferta.BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoomCpc];
                    var listadoOfertasTodasModel = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listadoOfertasTodas);
                    listadoOfertasTodasModel.Update(x =>
                    {
                        x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                        x.CodigoISO = userData.CodigoISO;
                        x.Simbolo = userData.Simbolo;
                    });
                    return listadoOfertasTodasModel;
                }

                List<ServiceOferta.BEShowRoomOferta> listaShowRoomCpc = GetProductosCompraPorCompraService(eventoId, campaniaId);
                listaShowRoomCpc = ObtenerListaProductoShowRoomMdo(listaShowRoomCpc);

                var listaTieneStock = new List<Lista>();
                var txtBuil = new StringBuilder();
                string codigoSap;
                if (esFacturacion)
                {
                    foreach (var beProducto in listaShowRoomCpc)
                    {
                        if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                        {
                            txtBuil.Append(beProducto.CodigoProducto + "|");
                        }
                    }

                    codigoSap = txtBuil.ToString();
                    codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                    try
                    {
                        if (!string.IsNullOrEmpty(codigoSap))
                        {
                            using (var sv = new wsConsulta())
                            {
                                sv.Url = GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
                                listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                        listaTieneStock = new List<Lista>();
                    }
                }

                var listaShowRoomCpcFinal = new List<ServiceOferta.BEShowRoomOferta>();
                txtBuil.Clear();
                foreach (var beShowRoomOferta in listaShowRoomCpc)
                {
                    bool tieneStockProl = true;
                    if (esFacturacion)
                    {
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
                        if (itemStockProl != null)
                            tieneStockProl = itemStockProl.estado == 1;
                    }

                    if (tieneStockProl)
                    {
                        txtBuil.Append(beShowRoomOferta.CodigoProducto + "|");
                        listaShowRoomCpcFinal.Add(beShowRoomOferta);
                    }
                }
                List<Producto> listaShowRoomProductoCatalogo;
                var numeroCampanias = Convert.ToInt32(GetConfiguracionManager(Constantes.ConfiguracionManager.NumeroCampanias));

                codigoSap = txtBuil.ToString();
                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);
                using (ProductoServiceClient sv = new ProductoServiceClient())
                {
                    listaShowRoomProductoCatalogo = sv.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, campaniaId, codigoSap, numeroCampanias).ToList();
                }

                foreach (var item in listaShowRoomCpcFinal)
                {
                    var beCatalogoPro = listaShowRoomProductoCatalogo.FirstOrDefault(p => p.CodigoSap == item.CodigoProducto);
                    if (beCatalogoPro != null)
                    {
                        item.ImagenProducto = beCatalogoPro.Imagen;
                        item.Descripcion = beCatalogoPro.NombreComercial;
                        item.DescripcionLegal = beCatalogoPro.Descripcion;
                    }
                }

                Session[Constantes.ConstSession.ListaProductoShowRoomCpc] = listaShowRoomCpcFinal;
                var listadoProductosCpcModel1 = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listaShowRoomCpcFinal);
                listadoProductosCpcModel1.Update(x =>
                {
                    x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                    x.CodigoISO = userData.CodigoISO;
                    x.Simbolo = userData.Simbolo;
                });

                return listadoProductosCpcModel1;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return null;
            }
        }

        protected EstrategiaPedidoModel ObtenerPrimeraOfertaShowRoom()
        {
            var ofertasShowRoom = ObtenerListaProductoShowRoomService(userData.CampaniaID, userData.CodigoConsultora);
            ofertasShowRoom = ObtenerListaProductoShowRoomMdo(ofertasShowRoom);
            ActualizarUrlImagenes(ofertasShowRoom);


            var ofertasShowRoomModel = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(ofertasShowRoom);
            ofertasShowRoomModel.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

            var ofertaShowRoomModel = ofertasShowRoomModel.FirstOrDefault();

            return ofertaShowRoomModel;
        }

        #region Metodos Privados
        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (sessionManager.GetUserData() != null)
            {
                ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
                int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
                if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim();

                ViewBag.NumeroCampania = userData.NombreCorto.Substring(4);
                ViewBag.EsUsuarioComunidad = userData.EsUsuarioComunidad ? 1 : 0;
                ViewBag.AnalyticsCampania = userData.CampaniaID;
                ViewBag.AnalyticsSegmento = string.IsNullOrEmpty(userData.Segmento) ? "(not available)" : userData.Segmento.Trim();
                ViewBag.AnalyticsEdad = Util.Edad(userData.FechaNacimiento);
                ViewBag.AnalyticsZona = userData.CodigoZona;
                ViewBag.AnalyticsPais = userData.CodigoISO;
                ViewBag.AnalyticsRol = "Consultora";
                ViewBag.AnalyticsRegion = userData.CodigorRegion;
                ViewBag.AnalyticsSeccion = string.IsNullOrEmpty(userData.SeccionAnalytics) ? "(not available)" : userData.SeccionAnalytics;
                ViewBag.AnalyticsCodigoConsultora = string.IsNullOrEmpty(userData.CodigoConsultora) ? "(not available)" : userData.CodigoConsultora;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                if (fechaHoy >= userData.FechaInicioCampania.Date && fechaHoy <= userData.FechaFinCampania.Date)
                    ViewBag.AnalyticsPeriodo = "Facturacion";
                else
                    ViewBag.AnalyticsPeriodo = "Venta";

                ViewBag.AnalyticsSegmentoConstancia = string.IsNullOrEmpty(userData.SegmentoConstancia) ? "(not available)" : userData.SegmentoConstancia.Trim();
                ViewBag.AnalyticsSociaNivel = string.IsNullOrEmpty(userData.DescripcionNivel) ? "(not available)" : userData.DescripcionNivel;
            }
        }

        private bool SiempreMostrarBannerPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            return false;
        }

        private bool NuncaMostrarBannerPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();

            return controllerName == "Pedido"
                || controllerName == "CatalogoPersonalizado"
                || controllerName == "ShowRoom"
                || controllerName == "SeguimientoPedido"
                || controllerName == "PedidosFacturados"
                || controllerName == "EstadoCuenta"
                || controllerName == "Cliente"
                || controllerName == "OfertaLiquidacion"
                || controllerName == "ConsultoraOnline"
                || controllerName == "ProductosAgotados"
                || controllerName == "Catalogo"
                || controllerName == "MiAsesorBelleza"
                || controllerName == "Notificaciones";
        }

        private bool NuncaMostrarBannerTopPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            return (controllerName == "Bienvenida" && actionName == "Index")
                   || controllerName == "Pedido"
                   || controllerName == "CatalogoPersonalizado"
                   || controllerName == "ShowRoom"
                   || controllerName == "SeguimientoPedido"
                   || controllerName == "PedidosFacturados"
                   || controllerName == "OfertaLiquidacion";

        }

        private void ActualizarUrlImagenes(List<ServiceOferta.BEShowRoomOferta> ofertasShowRoom)
        {
            ofertasShowRoom.Update(x =>
            {
                x.ImagenProducto = string.Empty;
                x.ImagenMini = string.Empty;
                if (string.IsNullOrEmpty(x.ImagenProducto))
                {
                    x.ImagenProducto = ConfigS3.GetUrlFileS3(ObtenerCarpetaPais(), x.ImagenProducto, ObtenerCarpetaPais());
                }
                if (string.IsNullOrEmpty(x.ImagenMini))
                {
                    x.ImagenProducto = ConfigS3.GetUrlFileS3(ObtenerCarpetaPais(), x.ImagenMini, ObtenerCarpetaPais());
                }
            });
        }

        private List<ServiceOferta.BEShowRoomOferta> ObtenerListaProductoShowRoomService(int campaniaId, string codigoConsultora)
        {
            List<ServiceOferta.BEShowRoomOferta> listaShowRoomOferta;

            using (OfertaServiceClient ofertaService = new OfertaServiceClient())
            {
                listaShowRoomOferta = ofertaService.GetShowRoomOfertasConsultora(userData.PaisID, campaniaId, codigoConsultora).ToList();
            }

            return listaShowRoomOferta;
        }

        private List<EstrategiaPedidoModel> ObtenerListaProductoShowRoomSession(List<BEPedidoWebDetalle> listaPedidoDetalle)
        {
            var listadoOfertasTodas = (List<ServiceOferta.BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoom];
            List<EstrategiaPedidoModel> listadoOfertasTodasModel = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listadoOfertasTodas);
            listadoOfertasTodasModel.Update(x =>
            {
                x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                x.CodigoISO = userData.CodigoISO;
                x.Simbolo = userData.Simbolo;
                x.Agregado = (listaPedidoDetalle.Find(p => p.CUV == x.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none";
                string CodigoEstrategia = listadoOfertasTodas.Where(f => f.CUV == x.CUV).Select(o => o.CodigoEstrategia).FirstOrDefault();

                x.TipoAccionAgregar = TipoAccionAgregar(0, Constantes.TipoEstrategiaCodigo.ShowRoom, false, CodigoEstrategia);

            });
            return listadoOfertasTodasModel;

        }

        private List<ServiceOferta.BEShowRoomOferta> ObtenerListaProductoShowRoomMdo(List<ServiceOferta.BEShowRoomOferta> listaShowRoomOferta, int flagRevistaValor = 0)
        {
            if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
            {
                listaShowRoomOferta = listaShowRoomOferta.Where(p => p.FlagRevista == (flagRevistaValor == 0 ? Constantes.FlagRevista.Valor0 : flagRevistaValor)).ToList();
            }
            return listaShowRoomOferta;

        }

        private List<EstrategiaPedidoModel> ObtenerListaProductoShowRoomFormato(List<ServiceOferta.BEShowRoomOferta> listaShowRoomOferta, List<BEPedidoWebDetalle> listaPedidoDetalle, bool esFacturacion)
        {
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            if (listaShowRoomOferta.Any())
            {
                listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));
            }

            var listaTieneStock = new List<Lista>();
            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                var txtBuil = new StringBuilder();
                foreach (var beProducto in listaShowRoomOferta)
                {
                    if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                    {
                        txtBuil.Append(beProducto.CodigoProducto + "|");
                    }
                }
                var codigoSap = txtBuil.ToString();
                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                try
                {
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new wsConsulta())
                        {
                            sv.Url = GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
                            listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                    listaTieneStock = new List<Lista>();
                }
            }

            var listaShowRoomOfertaFinal = new List<ServiceOferta.BEShowRoomOferta>();
            foreach (var beShowRoomOferta in listaShowRoomOferta)
            {
                bool tieneStockProl = true;
                if (esFacturacion)
                {
                    var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
                    if (itemStockProl != null)
                        tieneStockProl = itemStockProl.estado == 1;
                }
                if (tieneStockProl)
                {
                    listaShowRoomOfertaFinal.Add(beShowRoomOferta);
                }
            }

            Session[Constantes.ConstSession.ListaProductoShowRoom] = listaShowRoomOfertaFinal;
            List<EstrategiaPedidoModel> listadoOfertasTodasModel1 = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listaShowRoomOfertaFinal);

            listadoOfertasTodasModel1.Update(x =>
            {
                x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                x.CodigoISO = userData.CodigoISO;
                x.Simbolo = userData.Simbolo;
                x.Agregado = (listaPedidoDetalle.Find(p => p.CUV == x.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none";

                string CodigoEstrategia = listaShowRoomOfertaFinal.Where(f => f.CUV == x.CUV).Select(o => o.CodigoEstrategia).FirstOrDefault();

                x.TipoAccionAgregar = TipoAccionAgregar(0, Constantes.TipoEstrategiaCodigo.ShowRoom, false, CodigoEstrategia);
            });
            return listadoOfertasTodasModel1;
        }

        private List<ServiceOferta.BEShowRoomOferta> GetProductosCompraPorCompraService(int campaniaId, int eventoId)
        {
            List<ServiceOferta.BEShowRoomOferta> listaShowRoomCpc;

            using (OfertaServiceClient ofertaServiceClient = new OfertaServiceClient())
            {
                listaShowRoomCpc = ofertaServiceClient.GetProductosCompraPorCompra(userData.PaisID, eventoId, campaniaId).ToList();
            }

            return listaShowRoomCpc;
        }

        #endregion
    }
}