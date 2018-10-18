using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisReclamosController : BaseController
    {
        readonly CdrProvider _cdrProvider;

        public MisReclamosController()
        {
            _cdrProvider = new CdrProvider();
        }

        public ActionResult Index()
        {
            string sap = "";
            var url = (Request.Url.Query).Split('?');
            if (EsDispositivoMovil())
            {
                //return RedirectToAction("Index", "MisReclamos", new { area = "Mobile" });
                if (url.Length > 1)
                {
                    sap = "&" + url[1];
                    return RedirectToAction("Index", "MisReclamos", new { area = "Mobile", sap });
                }
                else
                {
                    return RedirectToAction("Index", "MisReclamos", new { area = "Mobile" });
                }
            }


            if (userData.TieneCDR == 0) return RedirectToAction("Index", "Bienvenida");

            MisReclamosModel model = new MisReclamosModel();
            List<CDRWebModel> listaCdrWebModel;
            try
            {
                using (CDRServiceClient cdr = new CDRServiceClient())
                {
                    var beCdrWeb = new BECDRWeb { ConsultoraID = userData.ConsultoraID };

                    var listaReclamo = cdr.GetCDRWeb(userData.PaisID, beCdrWeb).ToList();

                    listaCdrWebModel = Mapper.Map<List<BECDRWeb>, List<CDRWebModel>>(listaReclamo);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaCdrWebModel = new List<CDRWebModel>();
            }

            string urlPoliticaCdr = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPoliticasCDR) ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.ListaCDRWeb = listaCdrWebModel.FindAll(p => p.CantidadDetalle > 0);
            model.MensajeGestionCdrInhabilitada = _cdrProvider.MensajeGestionCdrInhabilitadaYChatEnLinea(userData.EsCDRWebZonaValida, userData.IndicadorBloqueoCDR, userData.FechaInicioCampania, userData.ZonaHoraria, userData.PaisID, userData.CampaniaID, userData.ConsultoraID);

            if (!string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return View(model);
            if (model.ListaCDRWeb.Count == 0) return RedirectToAction("Reclamo");
            return View(model);
        }

        public ActionResult Reclamo(int pedidoId = 0)
        {
            var model = new MisReclamosModel
            {
                PedidoID = pedidoId,
                MensajeGestionCdrInhabilitada = _cdrProvider.MensajeGestionCdrInhabilitadaYChatEnLinea(userData.EsCDRWebZonaValida, userData.IndicadorBloqueoCDR, userData.FechaInicioCampania, userData.ZonaHoraria, userData.PaisID, userData.CampaniaID, userData.ConsultoraID)
            };
            if (pedidoId == 0 && !string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return RedirectToAction("Index");

            _cdrProvider.CargarInformacion(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
            model.ListaCampania = SessionManager.GetCDRCampanias();
            if (model.ListaCampania.Count <= 1) return RedirectToAction("Index");

            if (pedidoId != 0)
            {
                var listaCdr = _cdrProvider.CargarBECDRWeb(new MisReclamosModel { PedidoID = pedidoId }, userData.PaisID, userData.ConsultoraID);
                if (listaCdr.Count == 0) return RedirectToAction("Index");

                if (listaCdr.Count == 1)
                {
                    model.CampaniaID = listaCdr[0].CampaniaID;
                    model.CDRWebID = listaCdr[0].CDRWebID;
                    model.NumeroPedido = listaCdr[0].PedidoNumero;
                }
            }

            string urlPoliticaCdr = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPoliticasCDR) ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.Email = userData.EMail;
            model.Telefono = userData.Celular;
            model.MontoMinimo = userData.MontoMinimo;

            model.TieneCDRExpress = userData.TieneCDRExpress;
            model.EsConsultoraNueva = userData.EsConsecutivoNueva;
            model.FleteDespacho = GetValorFleteExpress();
            model.MensajesExpress = new MensajesCDRExpressModel
            {
                RegularPrincipal = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.RegularPrincipal),
                RegularAdicional = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.RegularAdicional),
                ExpressPrincipal = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressPrincipal),
                ExpressAdicional = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressAdicional),
                Nuevas = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.Nuevas),
                ExpressFlete = SetMensajeFleteExpress(model.FleteDespacho)
            };

            int limiteMinimoTelef, limiteMaximoTelef;
            Util.GetLimitNumberPhone(userData.PaisID, out limiteMinimoTelef, out limiteMaximoTelef);
            model.limiteMinimoTelef = limiteMinimoTelef;
            model.limiteMaximoTelef = limiteMaximoTelef;

            return View(model);
        }

        private List<BEPedidoWeb> CargarPedidoCUV(MisReclamosModel model)
        {
            try
            {
                model.CUV = Util.SubStr(model.CUV, 0);

                var listaPedidoFacturados = _cdrProvider.CargarPedidosFacturados(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);

                var listaPedido = new List<BEPedidoWeb>();
                foreach (var pedido in listaPedidoFacturados)
                {
                    if (pedido.PedidoID == model.PedidoID || model.PedidoID == 0)
                    {
                        if (pedido.olstBEPedidoWebDetalle == null)
                            continue;

                        var lista = pedido.olstBEPedidoWebDetalle.Where(d => (d.CUV == model.CUV && d.CampaniaID == model.CampaniaID) || model.CUV == "").ToList();
                        if (lista.Any())
                        {
                            BEPedidoWeb pedidoActual = new BEPedidoWeb
                            {
                                CampaniaID = pedido.CampaniaID,
                                ImporteTotal = pedido.ImporteTotal,
                                Flete = pedido.Flete,
                                PedidoID = pedido.PedidoID,
                                FechaRegistro = pedido.FechaRegistro,
                                CanalIngreso = pedido.CanalIngreso,
                                CDRWebID = pedido.CDRWebID,
                                CDRWebEstado = pedido.CDRWebEstado,
                                NumeroPedido = pedido.NumeroPedido,
                                olstBEPedidoWebDetalle = lista.ToArray()
                            };

                            listaPedido.Add(pedidoActual);
                        }
                    }
                }
                return listaPedido;

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new List<BEPedidoWeb>();
            }
        }

        private List<BECDRWebMotivoOperacion> CargarOperacion(MisReclamosModel model)
        {
            var listaRetorno = new List<BECDRWebMotivoOperacion>();
            try
            {
                model.Motivo = Util.SubStr(model.Motivo, 0);
                var listaFiltro = _cdrProvider.CargarMotivoOperacionPorDias(model, userData.FechaActualPais.Date, userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                foreach (var item in listaFiltro)
                {
                    if (item.CodigoReclamo != model.Motivo && model.Motivo != "")
                        continue;

                    if (listaRetorno.Any(r => r.CodigoOperacion == item.CodigoOperacion))
                        continue;

                    var desc = _cdrProvider.ObtenerDescripcion(item.CDRTipoOperacion.CodigoOperacion, Constantes.TipoMensajeCDR.Solucion, userData.PaisID);
                    var add = new BECDRWebMotivoOperacion
                    {
                        CDRTipoOperacion = new BECDRTipoOperacion(),
                        CodigoOperacion = item.CodigoOperacion
                    };
                    add.CDRTipoOperacion.DescripcionOperacion = desc.Descripcion;
                    listaRetorno.Add(add);
                }

                return listaRetorno;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return listaRetorno;
            }
        }

        private bool TieneDetalleFueraFecha(BECDRWeb cdrWeb, MisReclamosModel model)
        {
            var operacionValidaList = _cdrProvider.CargarMotivoOperacionPorDias(model, userData.FechaActualPais.Date, userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
            return cdrWeb.CDRWebDetalle.Any(detalle =>
            {
                return !operacionValidaList.Any(operacion => operacion.CodigoOperacion == detalle.CodigoOperacion);
            });
        }

        private bool ValidarRegistro(MisReclamosModel model, out string mensajeError)
        {
            mensajeError = "";

            if (model.Cantidad <= 0)
                return false;

            model.CUV = Util.SubStr(model.CUV, 0);

            if (model.CUV == "")
                return false;

            var listaPedidoFacturados = CargarPedidoCUV(model);

            if (!listaPedidoFacturados.Any())
                return false;

            var pedido = listaPedidoFacturados.FirstOrDefault(p => p.PedidoID == model.PedidoID) ?? new BEPedidoWeb();

            if (pedido.olstBEPedidoWebDetalle == null)
                return false;

            if (pedido.olstBEPedidoWebDetalle.Count() != 1)
                return false;

            var detalle = pedido.olstBEPedidoWebDetalle[0];

            var listaCdrDetalle = _cdrProvider.CargarDetalle(model, userData.PaisID, userData.CodigoISO);
            listaCdrDetalle = listaCdrDetalle.Where(d => d.CUV == detalle.CUV).ToList();

            var cantidad = listaCdrDetalle.Sum(d => d.Cantidad);
            cantidad = detalle.Cantidad - (cantidad + model.Cantidad);

            if (cantidad < 0)
                mensajeError = "Lamentablemente la cantidad ingresada supera a la cantidad facturada en tu pedido (" +
                               detalle.Cantidad + ")";

            return cantidad >= 0;
        }

        public JsonResult BuscarCUV(MisReclamosModel model)
        {
            var listaPedidoFacturados = CargarPedidoCUV(model);

            return Json(new
            {
                success = true,
                message = "",
                detalle = listaPedidoFacturados
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BuscarCuvCambiar(MisReclamosModel model)
        {
            List<ServiceODS.BEProducto> olstProducto;
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();

            using (ODSServiceClient sv = new ODSServiceClient())
            {
                olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, model.CampaniaID, model.CUV, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, false).ToList();
            }

            if (olstProducto.Count == 0)
            {
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe.", TieneSugerido = 0 });
                return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
            }

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
                ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID,
                MensajeCUV = "",
                ObservacionCUV = "",
                DesactivaRevistaGana = 0,
                DescripcionMarca = olstProducto[0].DescripcionMarca,
                DescripcionEstrategia = olstProducto[0].DescripcionEstrategia,
                DescripcionCategoria = olstProducto[0].DescripcionCategoria,
                FlagNueva = olstProducto[0].FlagNueva,
                TipoEstrategiaID = olstProducto[0].TipoEstrategiaID,
                TieneSugerido = olstProducto[0].TieneSugerido,
                CodigoProducto = olstProducto[0].CodigoProducto,
                LimiteVenta = 99
            });

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BuscarMotivo(MisReclamosModel model)
        {
            var lista = _cdrProvider.CargarMotivo(model, userData.FechaActualPais.Date, userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
            return Json(new
            {
                success = true,
                message = "",
                detalle = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarPaso1(MisReclamosModel model)
        {
            #region Validar Pack y Sets

            try
            {
                using (WsGestionWeb sv = new WsGestionWeb())
                {
                    var respuestaServiceCdr = sv.GetCdrWebConsulta_Reclamo(userData.CodigoISO, model.CampaniaID.ToString(),
                        userData.CodigoConsultora, model.CUV, model.Cantidad, userData.CodigoZona);


                    if (respuestaServiceCdr[0].Codigo != "00")
                        return Json(new
                        {
                            success = false,
                            message = "No está permitido el reclamo de Packs y Sets por este medio. " + Constantes.CdrWebMensajes.ContactateChatEnLinea,
                        }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            #endregion

            string mensajeError;
            var valid = ValidarRegistro(model, out mensajeError);
            return Json(new
            {
                success = valid,
                message = mensajeError
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarNoPack(MisReclamosModel model)
        {
            #region Validar Pack y Sets

            try
            {
                using (WsGestionWeb sv = new WsGestionWeb())
                {
                    var respuestaServiceCdr = sv.GetCdrWebConsulta(userData.CodigoISO, model.CampaniaID.ToString(),
                        userData.CodigoConsultora, model.CUV, model.Cantidad, userData.CodigoZona);

                    if (respuestaServiceCdr[0].Codigo != "00")
                        return Json(new
                        {
                            success = false,
                            message = "No está permitido el cambio de Packs y Sets por este medio. " + Constantes.CdrWebMensajes.ContactateChatEnLinea,
                        }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            #endregion

            string mensajeError = "";
            return Json(new
            {
                success = true,
                message = mensajeError
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BuscarOperacion(MisReclamosModel model)
        {
            model.Operacion = "";
            var lista = CargarOperacion(model);
            return Json(new
            {
                success = true,
                message = "",
                detalle = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BuscarPropuesta(MisReclamosModel model)
        {
            model = model ?? new MisReclamosModel();
            var desc = _cdrProvider.ObtenerDescripcion(model.EstadoSsic, Constantes.TipoMensajeCDR.Propuesta, userData.PaisID);
            model.DescripcionConfirma = desc.Descripcion;
            model.CUV = Util.SubStr(model.CUV, 0);
            model.CUV2 = Util.SubStr(model.CUV2, 0);

            var descripcionTenerEnCuenta = _cdrProvider.ObtenerDescripcion(model.EstadoSsic, Constantes.TipoMensajeCDR.TenerEnCuenta, userData.PaisID).Descripcion;

            return Json(new
            {
                success = true,
                message = "",
                detalle = model,
                descripcionTenerEnCuenta
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BuscarParametria(MisReclamosModel model)
        {
            string codigoParametria;
            string codigoParametriaAbs;
            switch (model.EstadoSsic)
            {
                case "T":
                    codigoParametria = Constantes.ParametriaCDR.Trueque;
                    codigoParametriaAbs = Constantes.ParametriaCDR.TruequeValAbs;
                    break;
                case "D":
                    codigoParametria = Constantes.ParametriaCDR.Devolucion;
                    codigoParametriaAbs = "";
                    break;
                case "F":
                    codigoParametria = Constantes.ParametriaCDR.Faltante;
                    codigoParametriaAbs = "";
                    break;
                default:
                    codigoParametria = "";
                    codigoParametriaAbs = "";
                    break;
            }

            var listaParametria = _cdrProvider.CargarParametriaCdr(userData.PaisID);

            var parametria = listaParametria.FirstOrDefault(p => p.CodigoParametria == codigoParametria);
            parametria = parametria ?? new BECDRParametria();

            var parametriaAbs = listaParametria.FirstOrDefault(p => p.CodigoParametria == codigoParametriaAbs);
            parametriaAbs = parametriaAbs ?? new BECDRParametria();

            return Json(new
            {
                success = true,
                message = "",
                detalle = parametria,
                detalleAbs = parametriaAbs
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BuscarCdrWebDatos(MisReclamosModel model)
        {
            string codigoValor = "";
            switch (model.EstadoSsic)
            {
                case "T":
                    break;
                case "D":
                    break;
                case "F":
                    codigoValor = Constantes.CdrWebDatos.UnidadesPermitidasFaltante;
                    break;
                case "G":
                    codigoValor = Constantes.CdrWebDatos.UnidadesPermitidasFaltante;
                    break;
            }

            BECDRWebDatos cdrWebdatos = _cdrProvider.ObtenerCdrWebDatosByCodigo(codigoValor, userData.PaisID) ?? new BECDRWebDatos();
            return Json(new
            {
                success = true,
                message = "",
                cdrWebdatos = cdrWebdatos
            }, JsonRequestBehavior.AllowGet);
        }

        private bool ValidarDetalleGuardar(ref MisReclamosModel modelOri)
        {
            var model = modelOri ?? new MisReclamosModel();
            model.CUV = Util.SubStr(model.CUV, 0);
            model.CUV2 = Util.SubStr(model.CUV2, 0);

            string mensajeError = "";
            var valida = ValidarRegistro(model, out mensajeError);

            modelOri = model;
            if (!valida)
                return false;

            var cdrWebs = _cdrProvider.CargarBECDRWeb(model, userData.PaisID, userData.ConsultoraID);
            if (cdrWebs.Count != 1)
                return true;

            var cdrWeb = cdrWebs[0];

            if (cdrWeb.CDRWebID == -1 && model.Accion != "I")
                return false;

            model.CDRWebID = cdrWeb.CDRWebID;

            var lista = _cdrProvider.CargarDetalle(model, userData.PaisID, userData.CodigoISO);

            bool rpta = true;
            if (model.Accion == "I")
            {
                rpta = !lista.Any(d => d.CDRWebID == model.CDRWebID && d.CUV == model.CUV && d.CodigoOperacion == model.Operacion);
            }
            else if (model.Accion == "U")
            {

                rpta = lista.Any(d => d.CDRWebID == model.CDRWebID && d.CUV == model.CUV && d.CodigoOperacion == model.Operacion);
            }

            if (model.Accion == "")
                rpta = false;

            modelOri = model;
            return rpta;
        }

        public JsonResult DetalleGuardar(MisReclamosModel model)
        {
            try
            {
                model.Accion = "I";
                var rpta = ValidarDetalleGuardar(ref model);

                if (!rpta)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Ya tiene un detalle con el mismo cuv, y operación para el mismo pedido y campaña"
                    }, JsonRequestBehavior.AllowGet);
                }

                var entidadDetalle = new BECDRWebDetalle
                {
                    CDRWebID = model.CDRWebID,
                    CodigoReclamo = model.Motivo,
                    CodigoOperacion = model.Operacion,
                    CUV = model.CUV,
                    Cantidad = model.Cantidad
                };

                if (model.Operacion == Constantes.CodigoOperacionCDR.Canje)
                {
                    entidadDetalle.CUV2 = model.CUV;
                    entidadDetalle.Cantidad2 = model.Cantidad;
                }
                else
                {
                    entidadDetalle.CUV2 = model.CUV2;
                    entidadDetalle.Cantidad2 = model.CUV2 == "" ? 0 : model.Cantidad2;
                }

                int id;
                if (model.CDRWebID <= 0)
                {
                    var entidad = new BECDRWeb
                    {
                        CampaniaID = model.CampaniaID,
                        PedidoID = model.PedidoID,
                        PedidoNumero = model.NumeroPedido,
                        ConsultoraID = Int32.Parse(userData.ConsultoraID.ToString()),
                        EsMovilOrigen = Convert.ToBoolean(model.EsMovilOrigen),
                        CDRWebDetalle = new BECDRWebDetalle[] { entidadDetalle },
                        TipoDespacho = model.TipoDespacho,
                        FleteDespacho = userData.EsConsecutivoNueva ? 0 : model.FleteDespacho,
                        MensajeDespacho = model.MensajeDespacho
                    };

                    using (CDRServiceClient sv = new CDRServiceClient())
                    {
                        id = sv.InsCDRWeb(userData.PaisID, entidad);
                    }
                    model.CDRWebID = id;
                }
                else
                {
                    using (CDRServiceClient sv = new CDRServiceClient())
                    {
                        id = sv.InsCDRWebDetalle(userData.PaisID, entidadDetalle);
                    }
                    model.CDRWebDetalleID = id;
                }

                return Json(new
                {
                    success = id > 0,
                    message = id > 0 ? "" : "Error, vuelva a intentarlo",
                    detalle = model.CDRWebID
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, "MisReclamosController.DetalleGuardar");

                return Json(new
                {
                    success = false,
                    message = "Error, vuelva a intentarlo"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public bool TieneDetalleCDRExpress(List<BECDRWebDetalle> list)
        {
            var operacionesExpress = new List<string> {
                Constantes.CodigoOperacionCDR.Canje,
                Constantes.CodigoOperacionCDR.Trueque,
                Constantes.CodigoOperacionCDR.Faltante,
                Constantes.CodigoOperacionCDR.FaltanteAbono
            };
            return list.Any(x => operacionesExpress.Contains(x.CodigoOperacion));
        }

        public bool EvaluarVisibilidadCDRExpress(int cdrWebId, int pedidoId)
        {
            if (!userData.TieneCDRExpress) return false;

            var reclamoFiltro = new MisReclamosModel
            {
                CDRWebID = cdrWebId,
                PedidoID = pedidoId
            };
            return TieneDetalleCDRExpress(_cdrProvider.CargarDetalle(reclamoFiltro, userData.PaisID, userData.CodigoISO));
        }

        public JsonResult DetalleCargar(MisReclamosModel model)
        {
            SessionManager.SetCDRWebDetalle(null);
            var lista = _cdrProvider.CargarDetalle(model, userData.PaisID, userData.CodigoISO);

            return Json(new
            {
                success = true,
                message = "",
                detalle = lista,
                cantobservado = lista.Count(x => x.Estado == Constantes.EstadoCDRWeb.Observado),
                cantaprobado = lista.Count(x => x.Estado == Constantes.EstadoCDRWeb.Aceptado),
                esCDRExpress = TieneDetalleCDRExpress(lista),
                Simbolo = userData.Simbolo
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DetalleEliminar(MisReclamosModel model)
        {
            try
            {
                var entidadDetalle = new BECDRWebDetalle { CDRWebDetalleID = model.CDRWebDetalleID };

                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    sv.DelCDRWebDetalle(userData.PaisID, entidadDetalle);
                }

                return Json(new
                {
                    success = true,
                    message = "",
                    detalle = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Error: " + ex.Message,
                    detalle = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult SolicitudEnviar(MisReclamosModel model)
        {
            try
            {
                model = model ?? new MisReclamosModel();
                if (model.CDRWebID <= 0) return ErrorJson("Error, vuelva a intentarlo", true);

                string mensajeGestionCdrInhabilitada = _cdrProvider.MensajeGestionCdrInhabilitadaYChatEnLinea(userData.EsCDRWebZonaValida, userData.IndicadorBloqueoCDR, userData.FechaInicioCampania, userData.ZonaHoraria, userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                if (!string.IsNullOrEmpty(mensajeGestionCdrInhabilitada)) return ErrorJson(mensajeGestionCdrInhabilitada, true);

                var cdrWebFiltro = new BECDRWeb { ConsultoraID = userData.ConsultoraID, PedidoID = model.PedidoID };
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    var cdrWeb = sv.GetCDRWeb(userData.PaisID, cdrWebFiltro).FirstOrDefault();
                    if (cdrWeb == null) return ErrorJson("Error al buscar reclamo.", true);
                    cdrWeb.CDRWebDetalle = sv.GetCDRWebDetalle(userData.PaisID, new BECDRWebDetalle { CDRWebID = cdrWeb.CDRWebID }, cdrWeb.PedidoID);
                    if (TieneDetalleFueraFecha(cdrWeb, model)) return ErrorJson(Constantes.CdrWebMensajes.FueraDeFecha + " " + Constantes.CdrWebMensajes.ContactateChatEnLinea, true);
                }

                int resultadoUpdate;
                BECDRWeb cdrWebMailConfirmacion;
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    var entidad = new BECDRWeb
                    {
                        CDRWebID = model.CDRWebID,
                        Estado = Constantes.EstadoCDRWeb.Enviado,
                        TipoDespacho = !EvaluarVisibilidadCDRExpress(model.CDRWebID, model.PedidoID) ? null : model.TipoDespacho,
                        FleteDespacho = model.FleteDespacho,
                        MensajeDespacho = model.MensajeDespacho,
                        EsMovilFin = Convert.ToBoolean(model.EsMovilFin),
                    };

                    resultadoUpdate = sv.UpdEstadoCDRWeb(userData.PaisID, entidad);
                    sv.CreateLogCDRWebCulminadoFromCDRWeb(userData.PaisID, model.CDRWebID);

                    cdrWebMailConfirmacion = sv.GetCDRWeb(userData.PaisID, cdrWebFiltro).FirstOrDefault() ?? new BECDRWeb();
                    cdrWebMailConfirmacion.CDRWebDetalle = sv.GetCDRWebDetalle(userData.PaisID, new BECDRWebDetalle { CDRWebID = cdrWebMailConfirmacion.CDRWebID }, cdrWebMailConfirmacion.PedidoID);
                    cdrWebMailConfirmacion.CDRWebDetalle.Update(p => p.Solicitud = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado, userData.PaisID).Descripcion);
                    cdrWebMailConfirmacion.CDRWebDetalle.Update(p => p.SolucionSolicitada = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado, userData.PaisID).Descripcion);
                }

                int siNoEmail;
                using (UsuarioServiceClient us = new UsuarioServiceClient())
                {
                    siNoEmail = us.UpdateUsuarioEmailTelefono(userData.PaisID, userData.ConsultoraID, model.Email, model.Telefono);
                }

                RegistraLogDynamoCDR(model);

                userData.EMail = model.Email;
                userData.Celular = model.Telefono;
                SessionManager.SetUserData(userData);

                if (!string.IsNullOrWhiteSpace(model.Email))
                {
                    string contenidoMailCulminado = CrearEmailReclamoCulminado(cdrWebMailConfirmacion);
                    Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "CDR: EN EVALUACIÓN", contenidoMailCulminado, true, userData.NombreConsultora);

                    if (siNoEmail == 1)
                    {
                        string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
                        string paramQuerystring = Util.EncriptarQueryString(parametros);
                        string cadena = "<br /><br /> Estimada consultora " + userData.NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                         "<br /> <a href='" + Util.GetUrlHost(HttpContext.Request) + "WebPages/MailConfirmation.aspx?data=" + paramQuerystring + "'>aquí</a><br/><br/>Belcorp";
                        Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", model.Email, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, userData.NombreConsultora);

                        return Json(new
                        {
                            Cantidad = siNoEmail,
                            success = true,
                            message = "Sus datos se actualizaron correctamente.\n Se ha enviado un correo electrónico de verificación a la dirección ingresada.",
                            cdrWeb = cdrWebMailConfirmacion
                        }, JsonRequestBehavior.AllowGet);
                    }
                }

                return Json(new
                {
                    Cantidad = 0,
                    success = resultadoUpdate > 0,
                    message = resultadoUpdate > 0 ? "" : "Error, vuelva a intentarlo",
                    cdrWeb = cdrWebMailConfirmacion
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Error, vuelva a intentarlo", true);
            }
        }

        public JsonResult DetalleActualizarObservado(List<MisReclamosModel> lista)
        {
            try
            {
                var listaCdr = Mapper.Map<List<MisReclamosModel>, List<BECDRWebDetalle>>(lista);

                bool ok;
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    ok = sv.DetalleActualizarObservado(userData.PaisID, listaCdr.ToArray());
                }

                return Json(new
                {
                    success = ok,
                    message = ok ? "" : "Ocurrio un error al actualizar",
                    detalle = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Error: " + ex.Message,
                    detalle = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ObtenerMontoProductosCdrByCodigoOperacion(MisReclamosModel model)
        {
            var lista = _cdrProvider.CargarDetalle(model, userData.PaisID, userData.CodigoISO);

            var listaByCodigoOperacion = lista.FindAll(p => p.CodigoOperacion == model.EstadoSsic);

            var montoProductos = listaByCodigoOperacion.Sum(p => p.Cantidad * p.Precio);

            return Json(new
            {
                success = true,
                message = "",
                montoProductos,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCantidadProductosByCodigoSsic(MisReclamosModel model)
        {
            List<BECDRWebDetalle> listaByCodigoOperacion;
            var lista = _cdrProvider.CargarDetalle(model, userData.PaisID, userData.CodigoISO);

            if (model.EstadoSsic == Constantes.CodigoOperacionCDR.Faltante ||
                model.EstadoSsic == Constantes.CodigoOperacionCDR.FaltanteAbono)
                listaByCodigoOperacion = lista.FindAll(p => p.CodigoOperacion == Constantes.CodigoOperacionCDR.Faltante ||
                                       p.CodigoOperacion == Constantes.CodigoOperacionCDR.FaltanteAbono);
            else
                listaByCodigoOperacion = lista.FindAll(p => p.CodigoOperacion == model.EstadoSsic);


            var cantidadProductos = listaByCodigoOperacion.Sum(p => p.Cantidad);

            return Json(new
            {
                success = true,
                message = "",
                cantidadProductos,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidadTelefonoConsultora(string Telefono)
        {
            try
            {
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    var cantidad = svr.ValidarTelefonoConsultora(userData.PaisID, Telefono, userData.CodigoUsuario);
                    if (cantidad > 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "*Este número de celular ya está siendo utilizado. Intenta con otro.",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al intentar validar el teléfono",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ValidarCorreoDuplicado(string correo)
        {
            try
            {
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    var cantidad = svr.ValidarEmailConsultora(userData.PaisID, correo, userData.CodigoUsuario);

                    if (cantidad > 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "*Este correo ya está siendo utilizado. Intenta con otro",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al intentar validar el correo",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult ReporteDetalle()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MisReclamos/ReporteDetalle"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            int paisId = userData.PaisID;
            int campaniaIdActual;
            using (SACServiceClient sv = new SACServiceClient())
            {
                campaniaIdActual = sv.GetCampaniaFacturacionPais(paisId);
            }

            var cdrWebModel = new CDRWebModel()
            {
                listaPaises = DropDowListPaises(),
                lista = DropDowListCampanias(paisId),
                listaRegiones = _baseProvider.DropDownListRegiones(paisId),
                listaZonas = _baseProvider.DropDownListZonas(paisId),
                PaisID = paisId,
                CampaniaID = campaniaIdActual
            };

            return View(cdrWebModel);
        }

        public ActionResult ConsultaCRDWebDetalleReporte(string sidx, string sord, int page, int rows, string CampaniaID, string RegionID,
                                                         string ZonaID, string PaisID, string CodigoConsultora, string Estado, string Consulta, int? TipoConsultora)
        {
            if (ModelState.IsValid)
            {
                BECDRWeb entidad = new BECDRWeb
                {
                    CampaniaID = CampaniaID == "" ? 0 : int.Parse(CampaniaID),
                    RegionID = string.IsNullOrEmpty(RegionID) ? 0 : int.Parse(RegionID),
                    ZonaID = string.IsNullOrEmpty(ZonaID) ? 0 : int.Parse(ZonaID),
                    ConsultoraCodigo = CodigoConsultora,
                    Estado = string.IsNullOrEmpty(Estado) ? 0 : int.Parse(Estado),
                    TipoConsultora = TipoConsultora
                };

                List<BECDRWebDetalleReporte> lst;

                if (Consulta == "1")
                {
                    using (CDRServiceClient sv = new CDRServiceClient())
                    {
                        lst = sv.GetCDRWebDetalleReporte(PaisID == string.Empty ? 11 : int.Parse(PaisID), entidad).ToList();
                    }
                }
                else
                {
                    lst = new List<BECDRWebDetalleReporte>();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BECDRWebDetalleReporte> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NroCDR":
                            items = lst.OrderBy(x => x.NroCDR);
                            break;
                        case "ConsultoraCodigo":
                            items = lst.OrderBy(x => x.ConsultoraCodigo);
                            break;
                        case "ZonaCodigo":
                            items = lst.OrderBy(x => x.ZonaCodigo);
                            break;
                        case "SeccionCodigo":
                            items = lst.OrderBy(x => x.SeccionCodigo);
                            break;
                        case "CampaniaOrigenPedido":
                            items = lst.OrderBy(x => x.CampaniaOrigenPedido);
                            break;
                        case "FechaHoraSolicitud":
                            items = lst.OrderBy(x => x.FechaHoraSolicitud);
                            break;
                        case "FechaAtencion":
                            items = lst.OrderBy(x => x.FechaAtencion);
                            break;
                        case "EstadoDescripcion":
                            items = lst.OrderBy(x => x.EstadoDescripcion);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "UnidadesFacturadas":
                            items = lst.OrderBy(x => x.UnidadesFacturadas);
                            break;
                        case "MontoFacturado":
                            items = lst.OrderBy(x => x.MontoFacturado);
                            break;
                        case "UnidadesDevueltas":
                            items = lst.OrderBy(x => x.UnidadesDevueltas);
                            break;
                        case "MontoDevuelto":
                            items = lst.OrderBy(x => x.MontoDevuelto);
                            break;
                        case "CUV2":
                            items = lst.OrderBy(x => x.CUV2);
                            break;
                        case "UnidadesEnviar":
                            items = lst.OrderBy(x => x.UnidadesEnviar);
                            break;
                        case "MontoProductoEnviar":
                            items = lst.OrderBy(x => x.MontoProductoEnviar);
                            break;
                        case "Operacion":
                            items = lst.OrderBy(x => x.Operacion);
                            break;
                        case "Reclamo":
                            items = lst.OrderBy(x => x.Reclamo);
                            break;
                        case "EstadoDetalle":
                            items = lst.OrderBy(x => x.EstadoDetalle);
                            break;
                        case "OrigenCDRWeb":
                            items = lst.OrderBy(x => x.OrigenCDRWeb);
                            break;
                        case "TipoConsultora":
                            items = lst.OrderBy(x => x.TipoConsultora);
                            break;
                        case "TipoDespacho":
                            items = lst.OrderBy(x => x.TipoDespacho);
                            break;
                        case "FleteDespacho":
                            items = lst.OrderBy(x => x.FleteDespacho);
                            break;
                        case "MotivoRechazo":
                            items = lst.OrderBy(x => x.MotivoRechazo);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NroCDR":
                            items = lst.OrderByDescending(x => x.NroCDR);
                            break;
                        case "ConsultoraCodigo":
                            items = lst.OrderByDescending(x => x.ConsultoraCodigo);
                            break;
                        case "ZonaCodigo":
                            items = lst.OrderByDescending(x => x.ZonaCodigo);
                            break;
                        case "SeccionCodigo":
                            items = lst.OrderByDescending(x => x.SeccionCodigo);
                            break;
                        case "CampaniaOrigenPedido":
                            items = lst.OrderByDescending(x => x.CampaniaOrigenPedido);
                            break;
                        case "FechaHoraSolicitud":
                            items = lst.OrderByDescending(x => x.FechaHoraSolicitud);
                            break;
                        case "FechaAtencion":
                            items = lst.OrderByDescending(x => x.FechaAtencion);
                            break;
                        case "EstadoDescripcion":
                            items = lst.OrderByDescending(x => x.EstadoDescripcion);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "UnidadesFacturadas":
                            items = lst.OrderByDescending(x => x.UnidadesFacturadas);
                            break;
                        case "MontoFacturado":
                            items = lst.OrderByDescending(x => x.MontoFacturado);
                            break;
                        case "UnidadesDevueltas":
                            items = lst.OrderByDescending(x => x.UnidadesDevueltas);
                            break;
                        case "MontoDevuelto":
                            items = lst.OrderByDescending(x => x.MontoDevuelto);
                            break;
                        case "CUV2":
                            items = lst.OrderByDescending(x => x.CUV2);
                            break;
                        case "UnidadesEnviar":
                            items = lst.OrderBy(x => x.UnidadesEnviar);
                            break;
                        case "MontoProductoEnviar":
                            items = lst.OrderByDescending(x => x.MontoProductoEnviar);
                            break;
                        case "Operacion":
                            items = lst.OrderByDescending(x => x.Operacion);
                            break;
                        case "Reclamo":
                            items = lst.OrderByDescending(x => x.Reclamo);
                            break;
                        case "EstadoDetalle":
                            items = lst.OrderByDescending(x => x.EstadoDetalle);
                            break;
                        case "MotivoRechazo":
                            items = lst.OrderByDescending(x => x.MotivoRechazo);
                            break;
                        case "TipoConsultora":
                            items = lst.OrderByDescending(x => x.TipoConsultora);
                            break;
                        case "TipoDespacho":
                            items = lst.OrderByDescending(x => x.TipoDespacho);
                            break;
                        case "FleteDespacho":
                            items = lst.OrderByDescending(x => x.FleteDespacho);
                            break;
                        case "OrigenCDRWeb":
                            items = lst.OrderBy(x => x.OrigenCDRWeb);
                            break;
                    }
                }
                #endregion
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.NroCDR,
                               cell = new string[]
                               {
                            a.NroCDR ?? string.Empty,
                            a.ConsultoraCodigo ?? string.Empty,
                            a.RegionCodigo ?? string.Empty,
                            a.ZonaCodigo ?? string.Empty,
                            a.SeccionCodigo ?? string.Empty,
                            a.CampaniaOrigenPedido ?? string.Empty,
                            a.FechaHoraSolicitud ?? string.Empty,
                            a.FechaAtencion ?? string.Empty,
                            a.EstadoDescripcion ?? string.Empty,
                            a.CUV ?? string.Empty,
                            a.UnidadesFacturadas.ToString(),
                            a.MontoFacturado.ToString(),
                            a.UnidadesDevueltas.ToString(),
                            a.MontoDevuelto.ToString(),
                            a.CUV2 ?? string.Empty,
                            a.UnidadesEnviar.ToString(),
                            a.MontoProductoEnviar.ToString(),
                            a.Operacion ?? string.Empty,
                            a.Reclamo ?? string.Empty,
                            a.EstadoDetalle ?? string.Empty,
                            a.MotivoRechazo ?? string.Empty,
                            a.TipoConsultora ?? string.Empty,
                            a.TipoDespacho ?? string.Empty,
                            a.FleteDespacho.ToString(),
                            a.OrigenCDRWeb ?? string.Empty
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ExportarExcel(string CampaniaID, string RegionID, string ZonaID, string PaisID, string CodigoConsultora, string Estado, int? TipoConsultora)
        {
            BECDRWeb entidad = new BECDRWeb
            {
                CampaniaID = CampaniaID == "" ? 0 : int.Parse(CampaniaID),
                RegionID = string.IsNullOrEmpty(RegionID) ? 0 : int.Parse(RegionID),
                ZonaID = string.IsNullOrEmpty(ZonaID) ? 0 : int.Parse(ZonaID),
                ConsultoraCodigo = CodigoConsultora,
                Estado = string.IsNullOrEmpty(Estado) ? 0 : int.Parse(Estado),
                TipoConsultora = TipoConsultora
            };

            IList<BECDRWebDetalleReporte> lst;
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                lst = sv.GetCDRWebDetalleReporte(PaisID == string.Empty ? 11 : int.Parse(PaisID), entidad).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Nro. CDR", "NroCDR"},
                {"Código de cliente", "ConsultoraCodigo"},
                {"Región", "RegionCodigo"},
                {"Zona", "ZonaCodigo"},
                {"Sección", "SeccionCodigo"},
                {"Campaña Origen Pedido", "CampaniaOrigenPedido"},
                {"Fecha Hora Solicitud", "FechaHoraSolicitud"},
                {"Fecha Hora Atención", "FechaAtencion"},
                {"Estado del Reclamo", "EstadoDescripcion"},
                {"Código de Venta", "CUV"},
                {"Unidades facturadas", "UnidadesFacturadas"},
                {"Monto Facturado", "MontoFacturado"},
                {"Unidades devueltas", "UnidadesDevueltas"},
                {"Monto Devuelto", "MontoDevuelto"},
                {"Código de Venta Producto a Enviar", "CUV2"},
                {"Unidades a Enviar", "UnidadesEnviar"},
                {"Monto Producto a Enviar", "MontoProductoEnviar"},
                {"Operación", "Operacion"},
                {"Motivo", "Reclamo"},
                {"Estado", "EstadoDetalle"},
                {"Motivo Rechazo", "MotivoRechazo"},
                {"Segmento Consultora", "TipoConsultora"},
                {"Indicador Despacho", "TipoDespacho"},
                {"Flete CDR", "FleteDespacho"},
                {"Origen CDR Web", "OrigenCDRWeb"}
            };
            Util.ExportToExcel<BECDRWebDetalleReporte>("ReporteCDRWebDetalleExcel", lst.ToList(), dic);
            return View();
        }

        private string CrearEmailReclamoCulminado(BECDRWeb cdrWeb)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);
            var formatoCampania = cdrWeb.CampaniaID.ToString().Substring(0, 4) + "-" + cdrWeb.CampaniaID.ToString().Substring(4, 2);

            htmlTemplate = htmlTemplate.Replace("#FORMATO_NOMBRECOMPLETO#", userData.NombreConsultora);
            if (cdrWeb.FechaCulminado != null)
                htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHACULIMNADO#", cdrWeb.FechaCulminado.Value.ToString("dd/MM/yyyy"));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMEROSOLICITUD#", cdrWeb.CDRWebID.ToString());
            htmlTemplate = htmlTemplate.Replace("#FORMATO_CAMPANIA#", formatoCampania);

            #region Valores de Mensaje Express

            if (!string.IsNullOrEmpty(cdrWeb.MensajeDespacho))
            {
                var templateMensajeExpressPath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_mensaje_express.html";
                string htmlTemplateMensajeExpress = FileManager.GetContenido(templateMensajeExpressPath);
                htmlTemplateMensajeExpress = htmlTemplateMensajeExpress.Replace("#MENSAJE#", cdrWeb.MensajeDespacho);
                htmlTemplate = htmlTemplate.Replace("#MENSAJE_EXPRESS#", htmlTemplateMensajeExpress);
            }
            else htmlTemplate = htmlTemplate.Replace("#MENSAJE_EXPRESS#", "");

            #endregion

            #region Valores de Detalle

            var templateDetalleBasePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_detalle.html";
            string htmlTemplateDetalleBase = FileManager.GetContenido(templateDetalleBasePath);

            string templateDetalleOperacionCanjePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_detalle_codigo_operacion_canje.html";
            string templateDetalleOperacionDevolucionPath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_detalle_codigo_operacion_devolucion.html";
            string templateDetalleOperacionFaltantePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_detalle_codigo_operacion_faltante.html";
            string templateDetalleOperacionFaltanteAbonoPath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_detalle_codigo_operacion_faltanteAbono.html";
            string templateUrlDetalleOperacionTruequePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_detalle_codigo_operacion_trueque.html";

            var txtBuil = new StringBuilder();
            foreach (var cdrWebDetalle in cdrWeb.CDRWebDetalle)
            {
                string html = htmlTemplateDetalleBase.Clone().ToString();
                html = html.Replace("#FORMATO_CUV1#", cdrWebDetalle.CUV);

                string templateUrlDetalleOperacionBase =
                    cdrWebDetalle.CodigoOperacion == "C" ? templateDetalleOperacionCanjePath :
                    cdrWebDetalle.CodigoOperacion == "D" ? templateDetalleOperacionDevolucionPath :
                    cdrWebDetalle.CodigoOperacion == "F" ? templateDetalleOperacionFaltantePath :
                    cdrWebDetalle.CodigoOperacion == "G" ? templateDetalleOperacionFaltanteAbonoPath :
                    templateUrlDetalleOperacionTruequePath;

                string htmlTemplateDetalleOperacion = FileManager.GetContenido(templateUrlDetalleOperacionBase);
                string htmlOperacion = htmlTemplateDetalleOperacion.Clone().ToString();

                var precio = decimal.Round(cdrWebDetalle.Precio, 2);
                var precio2 = decimal.Round(cdrWebDetalle.Precio2, 2);
                var simbolo = userData.Simbolo;

                htmlOperacion = htmlOperacion.Replace("#FORMATO_DESCRIPCIONCUV1#", cdrWebDetalle.Descripcion);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_SOLICITUD#", cdrWebDetalle.Solicitud);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_CANTIDAD1#", cdrWebDetalle.Cantidad.ToString());
                htmlOperacion = htmlOperacion.Replace("#FORMATO_CUV2#", cdrWebDetalle.CUV2);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_PRECIO1#", simbolo + " " + precio);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_DESCRIPCIONCUV2#", cdrWebDetalle.Descripcion2);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_CANTIDAD2#", cdrWebDetalle.Cantidad2.ToString());
                htmlOperacion = htmlOperacion.Replace("#FORMATO_PRECIO2#", simbolo + " " + precio2);

                html = html.Replace("#FORMATO_DETALLE_TIPO_OPERACION#", htmlOperacion);
                txtBuil.Append(html);
            }
            htmlTemplate = htmlTemplate.Replace("#FORMATO_DETALLECDR#", txtBuil.ToString());

            #endregion

            return htmlTemplate;
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            PaisID = userData.PaisID;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ZonaModel> lstZonas = _baseProvider.DropDownListZonas(PaisID);
            IEnumerable<RegionModel> lstRegiones = _baseProvider.DropDownListRegiones(PaisID);

            return Json(new
            {
                lista = lst,
                listaZonas = lstZonas,
                listaRegiones = lstRegiones.OrderBy(x => x.Nombre)
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private List<BETablaLogicaDatos> GetListMensajeCDRExpress()
        {
            if (SessionManager.GetCDRExpressMensajes() != null)
            {
                return SessionManager.GetCDRExpressMensajes();
            }

            var listMensaje = new List<BETablaLogicaDatos>();
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    listMensaje = sv.GetTablaLogicaDatos(userData.PaisID, Constantes.TablaLogica.CDRExpress).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            SessionManager.SetCDRExpressMensajes(listMensaje);
            return listMensaje;
        }

        private string GetMensajeCDRExpress(string key)
        {
            var listMensaje = GetListMensajeCDRExpress();
            var item = listMensaje.FirstOrDefault(i => i.Codigo == key);
            return (item ?? new BETablaLogicaDatos()).Descripcion;
        }

        private decimal GetValorFleteExpress()
        {
            decimal costoFlete = 0;
            try
            {
                using (CDRServiceClient cdr = new CDRServiceClient())
                {
                    var flete = cdr.GetMontoFletePorZonaId(userData.PaisID, new BECDRWeb() { ZonaID = userData.ZonaID });
                    costoFlete = flete.FleteDespacho;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
            }
            return costoFlete;
        }

        private string SetMensajeFleteExpress(decimal flete)
        {
            if (flete <= 0) return GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressFleteCero);

            var textoFlete = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressFlete);
            return string.Format(textoFlete, userData.Simbolo, Util.DecimalToStringFormat(flete, userData.CodigoISO));
        }
    }
}
