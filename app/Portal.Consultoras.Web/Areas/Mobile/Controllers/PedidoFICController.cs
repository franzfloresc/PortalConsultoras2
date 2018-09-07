using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;
using BEPedidoWeb = Portal.Consultoras.Web.ServicePedido.BEPedidoWeb;
using BEPedidoWebDetalle = Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PedidoFICController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            var model = new PedidoMobileModel();

            sessionManager.SetObservacionesProl(null);
            sessionManager.SetPedidoWeb(null);
            sessionManager.SetDetallesPedido(null);

            var configuracionCampania = GetConfiguracionCampania(userData);
            if (configuracionCampania == null)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (configuracionCampania.CampaniaID == 0)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            var campaniaActual =  Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias).ToString();
            sessionManager.SetPedidoFIC(null);
            ViewBag.ClaseTabla = "tabla2";
            ViewBag.Pais_ISO = userData.CodigoISO;
            ViewBag.PROL = "Guardar";
            ViewBag.PROLDes = "Guarda los productos que haz ingresado";
            ViewBag.ModPedido = "display:none;";
            ViewBag.NombreConsultora = userData.NombreConsultora;
            ViewBag.PedidoFIC = "C" + (campaniaActual.Length == 6 ? campaniaActual.Substring (4,2) : campaniaActual);
            ViewBag.MensajeFIC = "antes del " + userData.FechaFinFIC.Day + " de " + Util.NombreMes(userData.FechaFinFIC.Month);
            ViewBag.FinFIc = userData.FechaFinFIC.ToString("dd/MM");
            ViewBag.FechaFinFIC = userData.FechaFinFIC.ToString("dd'/'MM");
            ViewBag.Campania = Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias).Substring(4,2);
            var olstPedidoFicDetalle = ObtenerPedidoFICDetalle();
            PedidoFICDetalleMobileModel modelo = new PedidoFICDetalleMobileModel
            {
                PaisID = userData.PaisID,
                ListaDetalle = olstPedidoFicDetalle,
                Simbolo = userData.Simbolo,
                Total = string.Format("{0:N2}", olstPedidoFicDetalle.Sum(p => p.ImporteTotal))
            };

            olstPedidoFicDetalle = olstPedidoFicDetalle ?? new List<BEPedidoFICDetalle>();


            if (userData.PedidoID == 0 && modelo.ListaDetalle.Count > 0)
            {
                userData.PedidoID = modelo.ListaDetalle[0].PedidoID;
                sessionManager.SetUserData(userData);
            }

            model.PaisId = userData.PaisID;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = ViewBag.Campania;
            model.CampaniaNro = userData.CampaniaNro;
            model.Total = olstPedidoFicDetalle.Sum(p => p.ImporteTotal);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, userData.CodigoISO);
            model.TotalMinimo = olstPedidoFicDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);

            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, userData.CodigoISO);

            model.ListaProductosFIC = olstPedidoFicDetalle.ToList();

            model.CantidadProductos = modelo.ListaDetalle.Sum(p => p.Cantidad);
            model.GananciaFormat = Util.DecimalToStringFormat(model.MontoAhorroCatalogo + model.MontoAhorroRevista, userData.CodigoISO);
            model.FormatoMontoAhorroCatalogo = Util.DecimalToStringFormat(model.MontoAhorroCatalogo, userData.CodigoISO);
            model.FormatoMontoAhorroRevista = Util.DecimalToStringFormat(model.MontoAhorroRevista, userData.CodigoISO);
            model.ListaClientes = GetClientesByConsultora(userData) ?? new List<BECliente>();
            model.ListaClientes.Insert(0, new BECliente { ClienteID = 0, Nombre = userData.NombreConsultora });
            model.ListaClientes.Insert(0, new BECliente { ClienteID = -1, Nombre = "NUEVO CLIENTE +" });
            model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            model.TieneCupon = userData.TieneCupon;
            model.EmailActivo = userData.EMailActivo;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = userData.CampaniaID.ToString();
            model.EMail = userData.EMail;
            model.Celular = userData.Celular;
            model.TieneMasVendidos = userData.TieneMasVendidos;
            var isMobileApp = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion", false) != null;
            var mobileConfiguracion = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");
            model.ClienteId = mobileConfiguracion.ClienteID;
            model.Nombre = string.Empty;

            if (isMobileApp && model.ListaClientes.Any(x => x.ClienteID == mobileConfiguracion.ClienteID))
            {
                var cli = model.ListaClientes.FirstOrDefault(x => x.ClienteID == mobileConfiguracion.ClienteID) ?? new BECliente();
                model.Nombre = cli.Nombre;
            }

            ViewBag.MobileApp = isMobileApp;
            ViewBag.MensajePedidoMobile = userData.MensajePedidoMobile;
            ViewBag.paisISO = userData.CodigoISO;
            ViewBag.Ambiente = _configuracionManagerProvider.GetBucketNameFromConfig();
            ViewBag.UrlFranjaNegra = _eventoFestivoProvider.GetUrlFranjaNegra();
            ViewBag.DataBarra = GetDataBarra2(true, true);

            model.MostrarPopupPrecargados = (GetMostradoPopupPrecargados() == 0);
            
            return View("Index", model);
            
        }

        private BEConfiguracionCampania GetConfiguracionCampania(UsuarioModel userDataParam)
        {
            BEConfiguracionCampania configuracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                configuracionCampania = sv.GetEstadoPedido(userDataParam.PaisID, userDataParam.CampaniaID, userDataParam.ConsultoraID, userDataParam.ZonaID, userDataParam.RegionID);
            }

            return configuracionCampania;
        }
        
        private List<BECliente> GetClientesByConsultora(UsuarioModel userDataParam)
        {
            List<BECliente> clientesByConsultora;
            using (var sv = new ClienteServiceClient())
            {
                clientesByConsultora = sv.SelectByConsultora(userDataParam.PaisID, userDataParam.ConsultoraID).ToList();
            }

            return clientesByConsultora;
        }

        public ActionResult virtualCoach(string param = "")
        {
            try
            {
                string cuv = param.Substring(0, 5);
                string campanaId = param.Substring(5, 6);
                int campana = Convert.ToInt32(campanaId);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return RedirectToAction("Detalle", new RouteValueDictionary(new { controller = "FichaProducto", area = "Mobile", param = param }));
        }

        public ActionResult Detalle(bool autoReservar = false)
        {
            sessionManager.SetObservacionesProl(null);
            sessionManager.SetDetallesPedido(null);

            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            if (beConfiguracionCampania == null)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (beConfiguracionCampania.CampaniaID == 0)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });
            
            var model = new PedidoDetalleMobileModel
            {
                AutoReservar = autoReservar,
                CodigoISO = userData.CodigoISO,
                Simbolo = userData.Simbolo,
                CampaniaActual = userData.CampaniaID.ToString(),
                FechaFacturacionPedido = ViewBag.FechaFacturacionPedido,
                FlagValidacionPedido = beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                                       && beConfiguracionCampania.ModificaPedidoReservado
                    ? "1"
                    : "0"
            };

            ValidarStatusCampania(beConfiguracionCampania);
            
            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month);

            if (!userData.DiaPROL)  // Periodo de venta
            {
                ViewBag.AccionBoton = "guardar";
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);

                if (userData.CodigoISO == "BO")
                {
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                }
            }

            model.PaisID = userData.PaisID;

            var olstPedidoFicDetalle = ObtenerPedidoFICDetalle();
            
            olstPedidoFicDetalle = olstPedidoFicDetalle ?? new List<BEPedidoFICDetalle>();
            
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
            model.EsFacturacion = esFacturacion;
            model.OfertaFinal = userData.OfertaFinal;
            model.EsOfertaFinalZonaValida = userData.EsOfertaFinalZonaValida;

            model.OfertaFinalGanaMas = userData.OfertaFinalGanaMas;
            model.EsOFGanaMasZonaValida = userData.EsOFGanaMasZonaValida;

            model.ListaParametriaOfertaFinal = GetParametriaOfertaFinal();
            model.EsConsultoraNueva = VerificarConsultoraNueva();
            model.MontoMinimo = userData.MontoMinimo;
            model.MontoMaximo = userData.MontoMaximo;
            model.Total = olstPedidoFicDetalle.Sum(p => p.ImporteTotal);
            model.DataBarra = GetDataBarra(true, true);

            ViewBag.CUVOfertaProl = TempData["CUVOfertaProl"];
            model.TieneCupon = userData.TieneCupon;
            model.EmailActivo = userData.EMailActivo;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = userData.CampaniaID.ToString();
            model.EMail = userData.EMail;
            model.Celular = userData.Celular;
            ViewBag.paisISO = userData.CodigoISO;
            ViewBag.Ambiente = _configuracionManagerProvider.GetBucketNameFromConfig();

            ViewBag.NombreConsultora = userData.Sobrenombre;
            if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                model.Prol = "GUARDA TU PEDIDO";
            var ofertaFinalModel = sessionManager.GetOfertaFinalModel();
            ViewBag.OfertaFinalEstado = ofertaFinalModel.Estado;
            ViewBag.OfertaFinalAlgoritmo = ofertaFinalModel.Algoritmo;
            ViewBag.UrlTerminosOfertaFinalRegalo = string.Format(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.oferta_final_regalo_url_s3), userData.CodigoISO);

            if (!sessionManager.GetEsShowRoom() && sessionManager.GetEsShowRoom().ToString() == "1")
            {
                ViewBag.ImagenFondoOFRegalo = _showRoomProvider.ObtenerValorPersonalizacionShowRoom("ImagenFondoOfertaFinalRegalo", "Mobile");
                ViewBag.Titulo1OFRegalo = _showRoomProvider.ObtenerValorPersonalizacionShowRoom("Titulo1OfertaFinalRegalo", "Mobile");
                ViewBag.ColorFondo1OFRegalo = _showRoomProvider.ObtenerValorPersonalizacionShowRoom("ColorFondo1OfertaFinalRegalo", "Mobile");
            }
            model.MostrarPopupPrecargados = (GetMostradoPopupPrecargados() == 0);

            var splited = model.DescripcionCampaniaActual.Split('-');
            var campania = Convert.ToInt32(splited[1]) + 1;
            ViewBag.DescripcionCampaniaActual = splited[0] + "-0" + campania;

            return View(model);
        }

        public BarraConsultoraModel GetDataBarra2(bool inEscala = true, bool inMensaje = false)
        {
            var objR = new BarraConsultoraModel
            {
                ListaEscalaDescuento = new List<BarraConsultoraEscalaDescuentoModel>(),
                ListaMensajeMeta = new List<BEMensajeMetaConsultora>()
            };

            try
            {

                var olstPedidoFicDetalle = ObtenerPedidoFICDetalle();
                olstPedidoFicDetalle = olstPedidoFicDetalle ?? new List<BEPedidoFICDetalle>(); 
                
                objR.TotalPedido = olstPedidoFicDetalle.Sum(p => p.ImporteTotal);
                objR.TotalPedidoStr = Util.DecimalToStringFormat(objR.TotalPedido, userData.CodigoISO);

                objR.CantidadProductos = olstPedidoFicDetalle.Sum(p => p.Cantidad);
                objR.CantidadCuv = olstPedidoFicDetalle.Count;

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return objR;
        }

        public ActionResult AutocompleteByProductoCUV(string term)
        {
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                List<ServiceODS.BEProducto> olstProducto;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias), term, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 5, true).ToList();
                }

                foreach (var item in olstProducto)
                {
                    olstProductoModel.Add(new ProductoModel()
                    {
                        CUV = item.CUV.Trim(),
                        Descripcion = item.Descripcion.Trim(),
                        PrecioCatalogo = item.PrecioCatalogo,
                        MarcaID = item.MarcaID,
                        EstaEnRevista = item.EstaEnRevista,
                        TieneStock = item.TieneStock,
                        EsExpoOferta = item.EsExpoOferta,
                        CUVRevista = item.CUVRevista.Trim(),
                        CUVComplemento = item.CUVComplemento.Trim(),
                        IndicadorMontoMinimo = item.IndicadorMontoMinimo.ToString().Trim(),
                        TipoOfertaSisID = item.TipoOfertaSisID,
                        ConfiguracionOfertaID = item.ConfiguracionOfertaID
                    });
                }

                if (olstProductoModel.Count == 0)
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe." });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
        }

        public ActionResult FindByCUV(PedidoDetalleModel model)
        {
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                List<ServiceODS.BEProducto> olstProducto;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias), model.CUV, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, true).ToList();
                }

                if (olstProducto.Count != 0)
                {
                    olstProductoModel.Add(new ProductoModel()
                    {
                        CUV = olstProducto[0].CUV.Trim(),
                        Descripcion = olstProducto[0].Descripcion.Trim(),
                        PrecioCatalogo = olstProducto[0].PrecioCatalogo,
                        MarcaID = olstProducto[0].MarcaID,
                        EstaEnRevista = olstProducto[0].EstaEnRevista,
                        TieneStock = olstProducto[0].TieneStock,
                        EsExpoOferta = olstProducto[0].EsExpoOferta,
                        CUVRevista = olstProducto[0].CUVRevista.Trim(),
                        CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                        IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                        TipoOfertaSisID = olstProducto[0].TipoOfertaSisID,
                        ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID
                    });
                }
                else
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe." });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);


        }

        public ActionResult CampaniaZonaNoConfigurada()
        {
            ViewBag.MensajeCampaniaZona = userData.CampaniaID == 0 ? "Campaña" : "Zona";
            return View();
        }

        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult Validado()
        {
            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            beConfiguracionCampania = beConfiguracionCampania ?? new BEConfiguracionCampania();

            if (beConfiguracionCampania.CampaniaID > userData.CampaniaID)
                return RedirectToAction("Index");

            if (beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && (beConfiguracionCampania.ModificaPedidoReservado
                || beConfiguracionCampania.ValidacionAbierta))
            {
                return RedirectToAction("Index", "Pedido", new { area = "Mobile" });
            }

            List<BEPedidoWebDetalle> lstPedidoWebDetalle;
            using (var sv = new PedidoServiceClient())
            {
                lstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
            }

            BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();

            var model = new PedidoDetalleMobileModel
            {
                CodigoISO = userData.CodigoISO,
                Simbolo = userData.Simbolo
            };
            model.SetDetalleMobileFromDetalleWeb(PedidoJerarquico(lstPedidoWebDetalle));
            model.Detalle.Update(item => item.DescripcionPrecioUnidad = Util.DecimalToStringFormat(item.PrecioUnidad, model.CodigoISO));
            model.Detalle.Update(item => item.DescripcionImporteTotal = Util.DecimalToStringFormat(item.ImporteTotal, model.CodigoISO));

            model.CantidadProductos = model.Detalle.Sum(item => item.Cantidad);
            model.PedidoConDescuentoCuv = userData.EstadoSimplificacionCUV && lstPedidoWebDetalle.Any(p => p.IndicadorOfertaCUV);
            model.PedidoConProductosExceptuadosMontoMinimo = lstPedidoWebDetalle.Any(p => p.IndicadorMontoMinimo == 0);

            model.SubTotal = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
            if (model.PedidoConDescuentoCuv) model.Descuento = -bePedidoWebByCampania.DescuentoProl;
            model.Total = model.SubTotal + model.Descuento;

            model.DescripcionSubTotal = Util.DecimalToStringFormat(model.SubTotal, model.CodigoISO);
            model.DescripcionDescuento = Util.DecimalToStringFormat(model.Descuento, model.CodigoISO);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, model.CodigoISO);

            model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, model.CodigoISO);

            model.MontoAhorroCatalogo = bePedidoWebByCampania.MontoAhorroCatalogo;
            model.MontoAhorroRevista = bePedidoWebByCampania.MontoAhorroRevista;
            model.GanaciaEstimada = model.MontoAhorroCatalogo + model.MontoAhorroRevista;
            model.DescripcionGanaciaEstimada = Util.DecimalToStringFormat(model.GanaciaEstimada, model.CodigoISO);

            ViewBag.MontoAhorroCatalogo = Util.DecimalToStringFormat(model.MontoAhorroCatalogo, userData.CodigoISO);
            ViewBag.MontoAhorroRevista = Util.DecimalToStringFormat(model.MontoAhorroRevista, userData.CodigoISO);
            model.PaisID = userData.PaisID;

            if (lstPedidoWebDetalle.Count != 0)
            {
                if (userData.PedidoID == 0)
                {
                    userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                    sessionManager.SetUserData(userData);
                }
                model.Email = userData.EMail;
            }

            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month);

            if (!userData.DiaPROL)  // Periodo de venta
            {
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);

                if (userData.CodigoISO == "BO")
                {
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                }
            }
            else // Periodo de facturacion
            {
                TimeSpan horaCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
                DateTime diaActual = DateTime.Today.Add(horaCierrePortal);

                model.Prol = "MODIFICA TU PEDIDO";
                model.ProlTooltip = "Modifica tu pedido sin perder lo que ya reservaste.";

                if (diaActual <= userData.FechaInicioCampania)
                {
                    model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                }
                else
                {
                    model.ProlTooltip += string.Format("|Hazlo antes de las {0} para facturarlo.", diaActual.ToString("hh:mm tt"));
                }
            }

            #region kitNueva
            BEKitNueva[] kitNueva;
            int esColaborador;
            using (var sv = new UsuarioServiceClient())
            {
                kitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora);
                esColaborador = sv.GetValidarColaboradorZona(userData.PaisID, userData.CodigoZona);
            }
            int esKitNueva = 0;
            decimal montoKitNueva = 0;

            //Valida de que la consultora tenga estado registrada y de que el proceso de kit de nueva este activo
            if (kitNueva[0].Estado == 1 && kitNueva[0].EstadoProceso == 1 && esColaborador == 0)
            {
                esKitNueva = 1;
                montoKitNueva = userData.MontoMinimo - kitNueva[0].Monto;
            }
            ViewBag.MontoKitNueva = Util.DecimalToStringFormat(montoKitNueva, model.CodigoISO);
            ViewBag.EsKitNueva = esKitNueva;
            #endregion 

            #region mensaje monto logro para la meta
            decimal montoLogro;
            string montoMaximoStr = Util.ValidaMontoMaximo(userData.MontoMaximo, userData.CodigoISO);
            if (!string.IsNullOrEmpty(montoMaximoStr) || model.SubTotal < userData.MontoMinimo) montoLogro = model.Total;
            else if (userData.MontoMinimo > bePedidoWebByCampania.MontoEscala) montoLogro = userData.MontoMinimo;
            else montoLogro = bePedidoWebByCampania.MontoEscala;

            BEFactorGanancia obeFactorGanancia;
            using (var sv = new SACServiceClient())
            {
                obeFactorGanancia = sv.GetFactorGananciaSiguienteEscala(montoLogro, userData.PaisID);
            }
            if (obeFactorGanancia != null && esColaborador == 0 && obeFactorGanancia.RangoMinimo <= userData.MontoMaximo)
            {
                model.MostrarEscalaDescuento = true;
                model.PorcentajeEscala = Convert.ToInt32(obeFactorGanancia.Porcentaje);
                model.MontoEscalaDescuento = obeFactorGanancia.RangoMinimo - montoLogro;
                model.DescripcionMontoEscalaDescuento = Util.DecimalToStringFormat(model.MontoEscalaDescuento, model.CodigoISO);
            }
            #endregion

            int horaCierre = userData.EsZonaDemAnti;
            TimeSpan sp = horaCierre == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            model.HoraCierre = Util.FormatearHora(sp);
            model.ModificacionPedidoProl = 0;

            if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                model.Prol = "GUARDA TU PEDIDO";

            return View(model);
        }
        
        private List<BEPedidoFICDetalle> ObtenerPedidoFICDetalle()
        {
            List<BEPedidoFICDetalle> list;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                list = sv.SelectFICByCampania(userData.PaisID, Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias), userData.ConsultoraID, userData.NombreConsultora).ToList();
            }
            sessionManager.SetPedidoFIC(list);
            return list;
        }


        [HttpPost]
        public JsonResult CargarDetallePedido(string sidx, string sord, int page, int rows, int clienteId, bool mobil = false)
        {
            try
            {
                PedidoSb2Model model = new PedidoSb2Model { CodigoIso = userData.CodigoISO };
                var listaDetalle = ObtenerPedidoFICDetalle() ?? new List<BEPedidoFICDetalle>();

                decimal total = listaDetalle.Sum(p => p.ImporteTotal);

                model.ListaCliente = (from item in listaDetalle
                                      select new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre }
                    ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                model.ListaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });

                listaDetalle = listaDetalle.Where(p => p.ClienteID == clienteId || clienteId == -1).ToList();
                decimal totalCliente = listaDetalle.Sum(p => p.ImporteTotal);

                var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoFICDetalle>, List<PedidoWebDetalleModel>>(listaDetalle);
                pedidoWebDetalleModel.Update(p => p.Simbolo = userData.Simbolo);
                pedidoWebDetalleModel.Update(p => p.CodigoIso = userData.CodigoISO);

                model.ListaDetalleModel = pedidoWebDetalleModel;
                model.Total = total;
                model.TotalConDescuento = total;
                model.TotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                model.TotalProductos = pedidoWebDetalleModel.Sum(p => Convert.ToInt32(p.Cantidad));

                userData.PedidoID = 0;
                if (model.ListaDetalleModel.Any())
                {
                    userData.PedidoID = model.ListaDetalleModel[0].PedidoID;
                    sessionManager.SetUserData(userData);

                    BEGrid grid = new BEGrid(sidx, sord, page, rows);
                    BEPager pag = Util.PaginadorGenerico(grid, model.ListaDetalleModel);

                    model.ListaDetalleModel = model.ListaDetalleModel.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();

                    model.Registros = grid.PageSize.ToString();
                    model.RegistrosTotal = pag.RecordCount.ToString();
                    model.Pagina = pag.CurrentPage.ToString();
                    model.PaginaDe = pag.PageCount.ToString();
                }
                else
                {
                    model.RegistrosTotal = "0";
                    model.Pagina = "1";
                    model.PaginaDe = "1";
                }

                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.Simbolo = userData.Simbolo;

                return Json(new
                {
                    success = false,
                    message = "OK",
                    data = model
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        [HttpPost]
        public JsonResult Delete(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad)
        {
            BEPedidoFICDetalle obe = new BEPedidoFICDetalle
            {
                PaisID = userData.PaisID,
                CampaniaID = CampaniaID,
                PedidoID = PedidoID,
                PedidoDetalleID = PedidoDetalleID,
                TipoOfertaSisID = TipoOfertaSisID,
                CUV = CUV,
                Cantidad = Cantidad
            };

            string mensaje;
            if (ReservadoEnHorarioRestringido(out mensaje))
            {
                return Json(new
                {
                    success = false,
                    message = mensaje
                }, JsonRequestBehavior.AllowGet);
            }

            bool errorServer;
            AdministradorPedido(obe, "D", out errorServer);
            if (errorServer)
            {
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al intentar eliminar el detalle"
                }, JsonRequestBehavior.AllowGet);
            }

            return Json(new
            {
                success = true,
                message = "El detalle se eliminó exitosamente."
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DeleteAll()
        {
            bool errorServer = false;
            string message = string.Empty;

            try
            {
                bool eliminacionMasiva;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    eliminacionMasiva = sv.DelPedidoFICDetalleMasivo(userData.PaisID, Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias), userData.PedidoID);
                }
                if (!eliminacionMasiva)
                {
                    errorServer = true;
                    message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
                }

            }
            catch
            {
                errorServer = true;
                message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            }

            return Json(new
            {
                success = !errorServer,
                message = message,
                extra = ""
            });

        }

        private List<BEPedidoFICDetalle> AdministradorPedido(BEPedidoFICDetalle obePedidoFicDetalle, string tipoAdm, out bool errorServer)
        {
            errorServer = false;
            List<BEPedidoFICDetalle> olstTempListado = new List<BEPedidoFICDetalle>();

            try
            {
                if (sessionManager.GetPedidoFIC() == null)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        olstTempListado = sv.SelectFICByCampania(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                    }
                    sessionManager.SetPedidoFIC(olstTempListado);
                }
                else olstTempListado = sessionManager.GetPedidoFIC();

                if (tipoAdm == "I")
                {
                    int cantidad;
                    short result = ValidarInsercion(olstTempListado, obePedidoFicDetalle, out cantidad);
                    if (result != 0)
                    {
                        tipoAdm = "U";
                        obePedidoFicDetalle.Stock = obePedidoFicDetalle.Cantidad;
                        obePedidoFicDetalle.Cantidad += cantidad;
                        obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
                        obePedidoFicDetalle.PedidoDetalleID = result;
                        obePedidoFicDetalle.Flag = 2;
                    }
                }
                else
                {
                    if (tipoAdm == "I_S")
                    {
                        int cantidad;
                        bool eliminacion;
                        short pedidoDetalleId;
                        short result = ValidarInsercionSession(olstTempListado, obePedidoFicDetalle, out cantidad, out eliminacion, out pedidoDetalleId);
                        if (result != 0)
                        {
                            tipoAdm = "U_S";
                            if (eliminacion)
                                obePedidoFicDetalle.EliminadoTemporal = false;
                            else
                                obePedidoFicDetalle.Cantidad += cantidad;

                            obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
                            obePedidoFicDetalle.PedidoDetalleID = result;
                        }
                    }
                }

                int totalClientes = CalcularTotalCliente(olstTempListado, obePedidoFicDetalle, tipoAdm == "D" || tipoAdm == "D_S" ? obePedidoFicDetalle.PedidoDetalleID : (short)0, tipoAdm);
                decimal totalImporte = CalcularTotalImporte(olstTempListado, obePedidoFicDetalle, tipoAdm == "I" || tipoAdm == "I_S" ? (short)0 : obePedidoFicDetalle.PedidoDetalleID, tipoAdm);
                obePedidoFicDetalle.ImporteTotalPedido = totalImporte;
                obePedidoFicDetalle.Clientes = totalClientes;

                switch (tipoAdm)
                {
                    case "I":
                        BEPedidoFICDetalle obe;
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            obe = sv.InsertFIC(obePedidoFicDetalle);
                        }
                        obe.ImporteTotal = obePedidoFicDetalle.ImporteTotal;
                        obe.DescripcionProd = obePedidoFicDetalle.DescripcionProd;
                        obe.Nombre = obePedidoFicDetalle.Nombre;

                        if (userData.PedidoID == 0)
                        {
                            userData.PedidoID = obe.PedidoID;
                            sessionManager.SetUserData(userData);
                        }

                        olstTempListado.Add(obe);

                        break;
                    case "U":

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoFICDetalle(obePedidoFicDetalle);
                        }

                        olstTempListado.Where(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = obePedidoFicDetalle.Cantidad;
                                p.ImporteTotal = obePedidoFicDetalle.ImporteTotal;
                                p.ClienteID = obePedidoFicDetalle.ClienteID;
                                p.DescripcionProd = obePedidoFicDetalle.DescripcionProd;
                                p.Nombre = obePedidoFicDetalle.Nombre;
                            });

                        break;
                    case "D":
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.DelPedidoFICDetalle(obePedidoFicDetalle);
                        }
                        olstTempListado.RemoveAll(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID);
                        break;
                    case "I_S":
                        obePedidoFicDetalle.PedidoDetalleID = Convert.ToInt16((1000 + DateTime.Now.Second + DateTime.Now.Millisecond).ToString());
                        obePedidoFicDetalle.EstadoItem = 1;
                        obePedidoFicDetalle.CUVNuevo = true;
                        obePedidoFicDetalle.ClaseFila = "f3";
                        olstTempListado.Add(obePedidoFicDetalle);
                        break;
                    case "U_S":
                        olstTempListado.Where(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = obePedidoFicDetalle.Cantidad;
                                p.ImporteTotal = obePedidoFicDetalle.ImporteTotal;
                                p.ClienteID = obePedidoFicDetalle.ClienteID;
                                p.DescripcionProd = obePedidoFicDetalle.DescripcionProd;
                                p.Nombre = obePedidoFicDetalle.Nombre;
                                p.EstadoItem = 2;
                                p.ClaseFila = "f3";
                                p.Stock = obePedidoFicDetalle.Stock;
                                p.Flag = obePedidoFicDetalle.Flag;
                                p.EliminadoTemporal = obePedidoFicDetalle.EliminadoTemporal;
                            });
                        break;
                    case "D_S":
                        olstTempListado.Where(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.EstadoItem = 3;
                                p.EliminadoTemporal = true;
                            });
                        break;
                }

                olstTempListado = olstTempListado.OrderByDescending(p => p.PedidoDetalleID).ToList();
                sessionManager.SetPedidoFIC(olstTempListado);

                errorServer = false;
            }
            catch
            {
                if (sessionManager.GetPedidoFIC() != null) olstTempListado = sessionManager.GetPedidoFIC();
                errorServer = true;
            }

            return olstTempListado;
        }

        private int CalcularTotalCliente(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            if (pedidoDetalleId == 0)
            {
                if (adm == "I" || adm == "I_S")
                    temp.Add(itemPedido);
                else
                    temp.Where(p => p.PedidoDetalleID == itemPedido.PedidoDetalleID).Update(p => p.ClienteID = itemPedido.ClienteID);

            }
            else
                temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();

            return temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            if (pedidoDetalleId == 0)
                temp.Add(itemPedido);
            else
                temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();
            return temp.Sum(p => p.ImporteTotal) + (adm == "U" || adm == "U_S" ? itemPedido.ImporteTotal : 0);
        }

        private short ValidarInsercion(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, out int cantidad)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            BEPedidoFICDetalle obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV);
            cantidad = obe != null ? obe.Cantidad : 0;
            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        private short ValidarInsercionSession(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, out int cantidad, out bool eliminacion, out short pedidoDetalleId)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            BEPedidoFICDetalle obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV);
            cantidad = obe != null ? obe.Cantidad : 0;
            if (obe != null)
            {
                eliminacion = obe.EliminadoTemporal;
                pedidoDetalleId = obe.PedidoDetalleID;
            }
            else
            {
                pedidoDetalleId = (short)0;
                eliminacion = false;
            }

            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        [HttpPost]
        public JsonResult Insert(PedidoDetalleModel model)
        {
            userData.PedidoID = 0;
            var olstPedidoFicDetal = ObtenerPedidoFICDetalle();
            if (olstPedidoFicDetal.Count != 0)
            {
                userData.PedidoID = olstPedidoFicDetal[0].PedidoID;
                sessionManager.SetUserData(userData);
            }

            BEPedidoFICDetalle obePedidoFicDetalle = new BEPedidoFICDetalle
            {
                IPUsuario = userData.IPUsuario,
                CampaniaID = Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias),
                ConsultoraID = userData.ConsultoraID,
                PaisID = userData.PaisID,
                TipoOfertaSisID = model.TipoOfertaSisID,
                ConfiguracionOfertaID = model.ConfiguracionOfertaID,
                ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID),
                PedidoID = userData.PedidoID,
                OfertaWeb = false,
                IndicadorMontoMinimo = Convert.ToInt32(model.IndicadorMontoMinimo)
            };

            if (model.Tipo != 2)
            {
                obePedidoFicDetalle.MarcaID = model.MarcaID;
                obePedidoFicDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                obePedidoFicDetalle.PrecioUnidad = model.PrecioUnidad;
                obePedidoFicDetalle.CUV = model.CUV;
            }
            else
            {
                obePedidoFicDetalle.MarcaID = model.MarcaIDComplemento;
                obePedidoFicDetalle.Cantidad = 1;
                obePedidoFicDetalle.PrecioUnidad = model.PrecioUnidadComplemento;
                obePedidoFicDetalle.CUV = model.CUVComplemento;
            }
            obePedidoFicDetalle.DescripcionProd = model.DescripcionProd;
            obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
            obePedidoFicDetalle.Nombre = obePedidoFicDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;

            bool errorServer;
            AdministradorPedido(obePedidoFicDetalle, "I", out errorServer);
            if (errorServer)
            {
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al intentar insertar el producto"
                }, JsonRequestBehavior.AllowGet);
            }

            return Json(new
            {
                success = true,
                message = "El producto se insertó exitosamente.",
                DataBarra = GetDataBarra2(true, true),
            });
        }

        [HttpPost]
        public JsonResult Update(PedidoFICDetalleModel model)
        {
            BEPedidoFICDetalle obePedidoFicDetalle = new BEPedidoFICDetalle
            {
                PaisID = userData.PaisID,
                CampaniaID = model.CampaniaID,
                PedidoID = model.PedidoID,
                PedidoDetalleID = model.PedidoDetalleID,
                Cantidad = Convert.ToInt32(model.Cantidad),
                PrecioUnidad = model.PrecioUnidad,
                ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID),
                CUV = model.CUV,
                TipoOfertaSisID = model.TipoOfertaSisID,
                Stock = model.Stock,
                Flag = model.Flag,
                DescripcionProd = model.DescripcionProd
            };

            obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
            obePedidoFicDetalle.Nombre = obePedidoFicDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;
            bool errorServer;
            var olstPedidoWebDetalle = AdministradorPedido(obePedidoFicDetalle, "U", out errorServer);

            decimal total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            string formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

            string totalCliente = "";
            if (model.ClienteID_ != "-1")
            {
                olstPedidoWebDetalle = (from item in olstPedidoWebDetalle
                                        where item.ClienteID == Convert.ToInt16(model.ClienteID_)
                                        select item).ToList();
                var tCliente = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                totalCliente = Util.DecimalToStringFormat(tCliente, userData.CodigoISO);
            }

            var message = errorServer ? "Hubo un problema al intentar actualizar el registro. Por favor inténtelo nuevamente." : "El registro ha sido actualizado de manera exitosa.";

            return Json(new
            {
                success = !errorServer,
                Total = total,
                FormatoTotal = formatoTotal,
                TotalCliente = totalCliente,
                ClienteID_ = model.ClienteID_,
                Simbolo = userData.Simbolo,
                message = message,
                extra = ""
            });
        }


        #endregion

        #region Metodos

        private void ValidarStatusCampania(BEConfiguracionCampania beConfiguracionCampania)
        {
            UsuarioModel usuario = userData;
            usuario.ZonaValida = beConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = beConfiguracionCampania.FechaInicioFacturacion;

            usuario.FechaFinCampania = beConfiguracionCampania.FechaFinFacturacion;

            usuario.HoraInicioReserva = beConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = beConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = beConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = beConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = beConfiguracionCampania.DiasAntes;

            bool mostrarBotonValidar;
            usuario.DiaPROL = ValidarPROL(usuario, out mostrarBotonValidar);
            usuario.MostrarBotonValidar = mostrarBotonValidar;
            usuario.NombreCorto = beConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = beConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = beConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = beConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = beConfiguracionCampania.HoraCierreZonaNormal;
            usuario.ValidacionAbierta = beConfiguracionCampania.ValidacionAbierta;

            if (DateTime.Now.AddHours(beConfiguracionCampania.ZonaHoraria) < beConfiguracionCampania.FechaInicioFacturacion.AddDays(-beConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = beConfiguracionCampania.FechaInicioFacturacion.AddDays(-beConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = beConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = beConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = beConfiguracionCampania.HoraFin;
            }
            sessionManager.SetUserData(usuario);
        }

        private int BuildFechaNoHabil()
        {
            int result = 0;
            if (sessionManager.GetUserData() != null)
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetFechaNoHabilFacturacion(userData.PaisID, userData.CodigoZona, DateTime.Today);
                }
            }
            return result;
        }

        private bool ValidarPROL(UsuarioModel usuario, out bool mostrarBotonValidar)
        {
            DateTime fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            bool diaProl = false;
            mostrarBotonValidar = false;
            TimeSpan horaNow = new TimeSpan(fechaHoraActual.Hour, fechaHoraActual.Minute, 0);

            if (fechaHoraActual > usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) &&
                fechaHoraActual < usuario.FechaInicioCampania)
            {
                if (horaNow > usuario.HoraInicioPreReserva && horaNow < usuario.HoraFinPreReserva)
                {
                    int cantidad = 0;
                    if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
                    {
                        cantidad = BuildFechaNoHabil();
                    }
                    mostrarBotonValidar = cantidad == 0;
                }
                diaProl = true;
            }
            else
            {
                if (fechaHoraActual > usuario.FechaInicioCampania &&
                    fechaHoraActual < usuario.FechaFinCampania.AddDays(1))
                {
                    if (horaNow > usuario.HoraInicioReserva && horaNow < usuario.HoraFinReserva)
                    {
                        int cantidad = 0;
                        if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
                        {
                            cantidad = BuildFechaNoHabil();
                        }
                        mostrarBotonValidar = cantidad == 0;
                    }
                    diaProl = true;
                }
            }
            return diaProl;
        }

        private List<BEPedidoWebDetalle> PedidoJerarquico(List<BEPedidoWebDetalle> listadoPedidos)
        {
            List<BEPedidoWebDetalle> result = new List<BEPedidoWebDetalle>();
            List<BEPedidoWebDetalle> padres = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == 0).ToList();
            foreach (var item in padres)
            {
                result.Add(item);
                var items = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == item.PedidoDetalleID).ToList();
                if (items.Any())
                    result.AddRange(items);
            }

            return result;
        }
        
        #endregion

        private List<BEEscalaDescuento> GetParametriaOfertaFinal()
        {
            List<BEEscalaDescuento> listaParametriaOfertaFinal;

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaParametriaOfertaFinal = sv.GetParametriaOfertaFinal(userData.PaisID, sessionManager.GetOfertaFinalModel().Algoritmo).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaParametriaOfertaFinal = new List<BEEscalaDescuento>();
            }

            return listaParametriaOfertaFinal;
        }

        public bool VerificarConsultoraNueva()
        {
            int segmentoId;

            if (userData.CodigoISO == "VE")
            {
                segmentoId = userData.SegmentoID;
            }
            else
            {
                segmentoId = userData.SegmentoInternoID == null ? userData.SegmentoID : (int)userData.SegmentoInternoID;
            }

            bool resultado = segmentoId == 1;

            return resultado;
        }

    }
}
