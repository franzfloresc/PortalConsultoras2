﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisReclamosController : BaseController
    {
        public ActionResult Index()
        {
            if (userData.TieneCDR == 0) return RedirectToAction("Index", "Bienvenida");

            MisReclamosModel model = new MisReclamosModel();
            var listaCDRWebModel = new List<CDRWebModel>();
            try
            {
                using (CDRServiceClient cdr = new CDRServiceClient())
                {
                    var beCdrWeb = new BECDRWeb();
                    beCdrWeb.ConsultoraID = userData.ConsultoraID;

                    var listaReclamo = cdr.GetCDRWeb(userData.PaisID, beCdrWeb).ToList();

                    listaCDRWebModel = Mapper.Map<List<BECDRWeb>, List<CDRWebModel>>(listaReclamo);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaCDRWebModel = new List<CDRWebModel>();
            }

            string urlPoliticaCdr = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPoliticasCDR) ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.ListaCDRWeb = listaCDRWebModel.FindAll(p => p.CantidadDetalle > 0);
            model.MensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitadaYChatEnLinea();

            if (!string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return View(model);
            if (model.ListaCDRWeb.Count == 0) return RedirectToAction("Reclamo");
            return View(model);
        }

        public ActionResult Reclamo(int pedidoId = 0)
        {
            var model = new MisReclamosModel { PedidoID = pedidoId };
            model.MensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitadaYChatEnLinea();
            if (pedidoId == 0 && !string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return RedirectToAction("Index");

            CargarInformacion();
            model.ListaCampania = (List<CampaniaModel>)Session[Constantes.ConstSession.CDRCampanias];
            if (model.ListaCampania.Count <= 1) return RedirectToAction("Index");

            if (pedidoId != 0)
            {
                var listaCdr = CargarBECDRWeb(new MisReclamosModel { PedidoID = pedidoId });
                if (listaCdr.Count == 0) return RedirectToAction("Index");

                if (listaCdr.Count == 1)
                {
                    model.CampaniaID = listaCdr[0].CampaniaID;
                    model.CDRWebID = listaCdr[0].CDRWebID;
                    model.NumeroPedido = listaCdr[0].PedidoNumero;
                }
            }

            string urlPoliticaCdr = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPoliticasCDR) ?? "{0}";
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
                Nuevas = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.Nuevas)
            };
            model.MensajesExpress.ExpressFlete = SetMensajeFleteExpress(model.FleteDespacho);

            if (userData.PaisID == 9)
            {
                model.limiteMinimoTelef = 5;
                model.limiteMaximoTelef = 15;
            }
            else if (userData.PaisID == 11)
            {
                model.limiteMinimoTelef = 7;
                model.limiteMaximoTelef = 9;
            }
            else if (userData.PaisID == 4)
            {
                model.limiteMinimoTelef = 10;
                model.limiteMaximoTelef = 10;
            }
            else if (userData.PaisID == 8 || userData.PaisID == 7 || userData.PaisID == 10 || userData.PaisID == 5)
            {
                model.limiteMinimoTelef = 8;
                model.limiteMaximoTelef = 8;
            }
            else if (userData.PaisID == 6)
            {
                model.limiteMinimoTelef = 9;
                model.limiteMaximoTelef = 10;
            }
            else
            {
                model.limiteMinimoTelef = 0;
                model.limiteMaximoTelef = 15;
            }

            return View(model);
        }

        private List<BEPedidoWeb> CargarPedidoCUV(MisReclamosModel model)
        {
            try
            {
                model.CUV = Util.SubStr(model.CUV, 0);

                var listaPedidoFacturados = CargarPedidosFacturados();

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
                            BEPedidoWeb pedidoActual = new BEPedidoWeb();
                            pedidoActual.CampaniaID = pedido.CampaniaID;
                            pedidoActual.ImporteTotal = pedido.ImporteTotal;
                            pedidoActual.Flete = pedido.Flete;
                            pedidoActual.PedidoID = pedido.PedidoID;
                            pedidoActual.FechaRegistro = pedido.FechaRegistro;
                            pedidoActual.CanalIngreso = pedido.CanalIngreso;
                            pedidoActual.CDRWebID = pedido.CDRWebID;
                            pedidoActual.CDRWebEstado = pedido.CDRWebEstado;
                            pedidoActual.NumeroPedido = pedido.NumeroPedido;
                            pedidoActual.olstBEPedidoWebDetalle = lista.ToArray();

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
                var listaFiltro = CargarMotivoOperacionPorDias(model);
                foreach (var item in listaFiltro)
                {
                    if (item.CodigoReclamo != model.Motivo && model.Motivo != "")
                        continue;

                    if (listaRetorno.Any(r => r.CodigoOperacion == item.CodigoOperacion))
                        continue;

                    var desc = ObtenerDescripcion(item.CDRTipoOperacion.CodigoOperacion, Constantes.TipoMensajeCDR.Solucion);
                    var add = new BECDRWebMotivoOperacion();
                    add.CDRTipoOperacion = new BECDRTipoOperacion();
                    add.CodigoOperacion = item.CodigoOperacion;
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
            var operacionValidaList = CargarMotivoOperacionPorDias(model);
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

            var listaCDRDetalle = CargarDetalle(model);
            listaCDRDetalle = listaCDRDetalle.Where(d => d.CUV == detalle.CUV).ToList();

            var cantidad = listaCDRDetalle.Sum(d => d.Cantidad);
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
            List<BEProducto> olstProducto = new List<BEProducto>();
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
            var lista = CargarMotivo(model);
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
                var respuestaServiceCdr = new RptCdr[1];
                using (WsGestionWeb sv = new WsGestionWeb())
                {
                    respuestaServiceCdr = sv.GetCdrWebConsulta_Reclamo(userData.CodigoISO, model.CampaniaID.ToString(),
                        userData.CodigoConsultora, model.CUV, model.Cantidad, userData.CodigoZona);


                    if (respuestaServiceCdr[0].Codigo != "00")
                        return Json(new
                        {
                            success = false,
                            message = "No está permitido el reclamo de Packs y Sets por este medio. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.",
                        }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            #endregion

            string mensajeError = "";
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
                var respuestaServiceCdr = new RptCdr[1];
                using (WsGestionWeb sv = new WsGestionWeb())
                {
                    respuestaServiceCdr = sv.GetCdrWebConsulta(userData.CodigoISO, model.CampaniaID.ToString(),
                        userData.CodigoConsultora, model.CUV, model.Cantidad, userData.CodigoZona);

                    if (respuestaServiceCdr[0].Codigo != "00")
                        return Json(new
                        {
                            success = false,
                            message = "No está permitido el cambio de Packs y Sets por este medio. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.",
                        }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            #endregion

            string mensajeError = "";
            var valid = true;
            return Json(new
            {
                success = valid,
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
            var desc = ObtenerDescripcion(model.EstadoSsic, Constantes.TipoMensajeCDR.Propuesta);
            model.DescripcionConfirma = desc.Descripcion;
            model.CUV = Util.SubStr(model.CUV, 0);
            model.CUV2 = Util.SubStr(model.CUV2, 0);

            var descripcionTenerEnCuenta = ObtenerDescripcion(model.EstadoSsic, Constantes.TipoMensajeCDR.TenerEnCuenta).Descripcion;

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
            string codigoParametria = "";
            string codigoParametriaAbs = "";
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

            var listaParametria = CargarParametriaCdr();

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
                default:
                    break;
            }

            BECDRWebDatos cdrWebdatos = ObtenerCdrWebDatosByCodigo(codigoValor) ?? new BECDRWebDatos();
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

            var cdrWebs = CargarBECDRWeb(model);
            if (cdrWebs.Count != 1)
                return true;

            var cdrWeb = cdrWebs[0];

            if (cdrWeb.CDRWebID == -1 && model.Accion != "I")
                return false;

            model.CDRWebID = cdrWeb.CDRWebID;

            var lista = CargarDetalle(model);

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
                var id = 0;
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

                var entidadDetalle = new BECDRWebDetalle();
                entidadDetalle.CDRWebID = model.CDRWebID;
                entidadDetalle.CodigoReclamo = model.Motivo;
                entidadDetalle.CodigoOperacion = model.Operacion;
                entidadDetalle.CUV = model.CUV;
                entidadDetalle.Cantidad = model.Cantidad;

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

                if (model.CDRWebID <= 0)
                {
                    var entidad = new BECDRWeb();
                    entidad.CampaniaID = model.CampaniaID;
                    entidad.PedidoID = model.PedidoID;
                    entidad.PedidoNumero = model.NumeroPedido;
                    entidad.ConsultoraID = Int32.Parse(userData.ConsultoraID.ToString());
                    entidad.EsMovilOrigen = Convert.ToBoolean(model.EsMovilOrigen);
                    entidad.CDRWebDetalle = new BECDRWebDetalle[] { entidadDetalle };

                    entidad.TipoDespacho = model.TipoDespacho;
                    entidad.FleteDespacho = userData.EsConsecutivoNueva ? 0 : model.FleteDespacho;
                    entidad.MensajeDespacho = model.MensajeDespacho;

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
            var OperacionesExpress = new List<string> {
                Constantes.CodigoOperacionCDR.Canje,
                Constantes.CodigoOperacionCDR.Trueque,
                Constantes.CodigoOperacionCDR.Faltante,
                Constantes.CodigoOperacionCDR.FaltanteAbono
            };
            return list.Any(x => OperacionesExpress.Contains(x.CodigoOperacion));
        }

        public bool EvaluarVisibilidadCDRExpress(int cdrWebId, int pedidoId)
        {
            if (!userData.TieneCDRExpress) return false;

            var reclamoFiltro = new MisReclamosModel
            {
                CDRWebID = cdrWebId,
                PedidoID = pedidoId
            };
            return TieneDetalleCDRExpress(CargarDetalle(reclamoFiltro));
        }

        public JsonResult DetalleCargar(MisReclamosModel model)
        {
            Session[Constantes.ConstSession.CDRWebDetalle] = null;
            var lista = CargarDetalle(model);

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
                var entidadDetalle = new BECDRWebDetalle();
                entidadDetalle.CDRWebDetalleID = model.CDRWebDetalleID;

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

                string mensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitadaYChatEnLinea();
                if (!string.IsNullOrEmpty(mensajeGestionCdrInhabilitada)) return ErrorJson(mensajeGestionCdrInhabilitada, true);

                var cdrWebFiltro = new BECDRWeb { ConsultoraID = userData.ConsultoraID, PedidoID = model.PedidoID };
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    var cdrWeb = sv.GetCDRWeb(userData.PaisID, cdrWebFiltro).ToList().FirstOrDefault();
                    if (cdrWeb == null) return ErrorJson("Error al buscar reclamo.", true);
                    cdrWeb.CDRWebDetalle = sv.GetCDRWebDetalle(userData.PaisID, new BECDRWebDetalle { CDRWebID = cdrWeb.CDRWebID }, cdrWeb.PedidoID);
                    if (TieneDetalleFueraFecha(cdrWeb, model)) return ErrorJson(Constantes.CdrWebMensajes.FueraDeFecha + " " + Constantes.CdrWebMensajes.ContactateChatEnLinea, true);
                }

                int resultadoUpdate = 0;
                var cDRWebMailConfirmacion = new BECDRWeb();
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

                    cDRWebMailConfirmacion = sv.GetCDRWeb(userData.PaisID, cdrWebFiltro).ToList().FirstOrDefault() ?? new BECDRWeb();
                    cDRWebMailConfirmacion.CDRWebDetalle = sv.GetCDRWebDetalle(userData.PaisID, new BECDRWebDetalle { CDRWebID = cDRWebMailConfirmacion.CDRWebID }, cDRWebMailConfirmacion.PedidoID);
                    cDRWebMailConfirmacion.CDRWebDetalle.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado).Descripcion);
                    cDRWebMailConfirmacion.CDRWebDetalle.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado).Descripcion);
                }

                int SiNoEmail = 0;
                using (UsuarioServiceClient us = new UsuarioServiceClient())
                {
                    SiNoEmail = us.UpdateUsuarioEmailTelefono(userData.PaisID, userData.ConsultoraID, model.Email, model.Telefono);
                }
                userData.EMail = model.Email;
                userData.Celular = model.Telefono;
                SetUserData(userData);

                if (!string.IsNullOrWhiteSpace(model.Email))
                {
                    string contenidoMailCulminado = CrearEmailReclamoCulminado(cDRWebMailConfirmacion);
                    Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "CDR: EN EVALUACIÓN", contenidoMailCulminado, true, userData.NombreConsultora);

                    if (SiNoEmail == 1)
                    {
                        string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
                        string param_querystring = Util.EncriptarQueryString(parametros);
                        string cadena = "<br /><br /> Estimada consultora " + userData.NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                         "<br /> <a href='" + Util.GetUrlHost(HttpContext.Request) + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'>aquí</a><br/><br/>Belcorp";
                        Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", model.Email, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, userData.NombreConsultora);

                        return Json(new
                        {
                            Cantidad = SiNoEmail,
                            success = true,
                            message = "Sus datos se actualizaron correctamente.\n Se ha enviado un correo electrónico de verificación a la dirección ingresada.",
                            cdrWeb = cDRWebMailConfirmacion
                        }, JsonRequestBehavior.AllowGet);
                    }
                }

                return Json(new
                {
                    Cantidad = 0,
                    success = resultadoUpdate > 0,
                    message = resultadoUpdate > 0 ? "" : "Error, vuelva a intentarlo",
                    cdrWeb = cDRWebMailConfirmacion
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
                Mapper.CreateMap<MisReclamosModel, BECDRWebDetalle>()
                    .ForMember(t => t.CDRWebDetalleID, f => f.MapFrom(c => c.CDRWebDetalleID))
                    .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad));

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
            var listaByCodigoOperacion = new List<BECDRWebDetalle>();
            var lista = CargarDetalle(model);

            listaByCodigoOperacion = lista.FindAll(p => p.CodigoOperacion == model.EstadoSsic);

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
            var listaByCodigoOperacion = new List<BECDRWebDetalle>();
            var lista = CargarDetalle(model);

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
                int cantidad = 0;
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    cantidad = svr.ValidarTelefonoConsultora(userData.PaisID, Telefono, userData.CodigoUsuario);
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
                int cantidad = 0;
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    cantidad = svr.ValidarEmailConsultora(userData.PaisID, correo, userData.CodigoUsuario);

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            int PaisId = UserData().PaisID;
            int CampaniaIDActual = 0;
            using (Portal.Consultoras.Web.ServiceSAC.SACServiceClient sv = new Portal.Consultoras.Web.ServiceSAC.SACServiceClient())
            {
                CampaniaIDActual = sv.GetCampaniaFacturacionPais(PaisId);
            }

            var cdrWebModel = new CDRWebModel()
            {
                listaPaises = DropDowListPaises(),
                lista = DropDowListCampanias(PaisId),
                listaRegiones = DropDownListRegiones(PaisId),
                listaZonas = DropDownListZonas(PaisId),
                PaisID = PaisId,
                CampaniaID = CampaniaIDActual
            };

            return View(cdrWebModel);
        }

        public ActionResult ConsultaCRDWebDetalleReporte(string sidx, string sord, int page, int rows, string CampaniaID, string RegionID,
                                                         string ZonaID, string PaisID, string CodigoConsultora, string Estado, string Consulta, int? TipoConsultora)
        {
            if (ModelState.IsValid)
            {
                BECDRWeb entidad = new BECDRWeb();
                entidad.CampaniaID = CampaniaID == "" ? 0 : int.Parse(CampaniaID);
                entidad.RegionID = RegionID.Equals(string.Empty) ? 0 : int.Parse(RegionID);
                entidad.ZonaID = ZonaID.Equals(string.Empty) ? 0 : int.Parse(ZonaID);
                entidad.ConsultoraCodigo = CodigoConsultora;
                entidad.Estado = Estado.Equals(string.Empty) ? 0 : int.Parse(Estado);
                entidad.TipoConsultora = TipoConsultora;

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

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
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
                pag = Util.PaginadorGenerico(grid, lst);

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
                                   (a.NroCDR??string.Empty).ToString(),
                                   (a.ConsultoraCodigo??string.Empty).ToString(),
                                   (a.RegionCodigo??string.Empty).ToString(),
                                   (a.ZonaCodigo??string.Empty).ToString(),
                                   (a.SeccionCodigo??string.Empty).ToString(),
                                   (a.CampaniaOrigenPedido??string.Empty).ToString(),
                                   (a.FechaHoraSolicitud??string.Empty).ToString(),
                                   (a.FechaAtencion??string.Empty).ToString(),
                                   (a.EstadoDescripcion??string.Empty).ToString(),
                                   (a.CUV??string.Empty).ToString(),
                                   a.UnidadesFacturadas.ToString(),
                                   a.MontoFacturado.ToString(),
                                   a.UnidadesDevueltas.ToString(),
                                   a.MontoDevuelto.ToString(),
                                   (a.CUV2??string.Empty).ToString(),
                                   a.UnidadesEnviar.ToString(),
                                   a.MontoProductoEnviar.ToString(),
                                   (a.Operacion??string.Empty).ToString(),
                                   (a.Reclamo??string.Empty).ToString(),
                                   (a.EstadoDetalle??string.Empty).ToString(),
                                   (a.MotivoRechazo??string.Empty).ToString(),                                   
                                   (a.TipoConsultora ?? string.Empty).ToString(),
                                   (a.TipoDespacho??string.Empty).ToString(),
                                   a.FleteDespacho.ToString(),
                                   (a.OrigenCDRWeb??string.Empty).ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ExportarExcel(string CampaniaID, string RegionID, string ZonaID, string PaisID, string CodigoConsultora, string Estado, int? TipoConsultora)
        {
            BECDRWeb entidad = new BECDRWeb();
            entidad.CampaniaID = CampaniaID == "" ? 0 : int.Parse(CampaniaID);
            entidad.RegionID = RegionID.Equals(string.Empty) ? 0 : int.Parse(RegionID);
            entidad.ZonaID = ZonaID.Equals(string.Empty) ? 0 : int.Parse(ZonaID);
            entidad.ConsultoraCodigo = CodigoConsultora;
            entidad.Estado = Estado.Equals(string.Empty) ? 0 : int.Parse(Estado);
            entidad.TipoConsultora = TipoConsultora;

            IList<BECDRWebDetalleReporte> lst;
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                lst = sv.GetCDRWebDetalleReporte(PaisID == string.Empty ? 11 : int.Parse(PaisID), entidad).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Nro. CDR", "NroCDR");
            dic.Add("Código de cliente", "ConsultoraCodigo");
            dic.Add("Región", "RegionCodigo");
            dic.Add("Zona", "ZonaCodigo");
            dic.Add("Sección", "SeccionCodigo");
            dic.Add("Campaña Origen Pedido", "CampaniaOrigenPedido");
            dic.Add("Fecha Hora Solicitud", "FechaHoraSolicitud");
            dic.Add("Fecha Hora Atención", "FechaAtencion");
            dic.Add("Estado del Reclamo", "EstadoDescripcion");
            dic.Add("Código de Venta", "CUV");
            dic.Add("Unidades facturadas", "UnidadesFacturadas");
            dic.Add("Monto Facturado", "MontoFacturado");
            dic.Add("Unidades devueltas", "UnidadesDevueltas");
            dic.Add("Monto Devuelto", "MontoDevuelto");
            dic.Add("Código de Venta Producto a Enviar", "CUV2");
            dic.Add("Unidades a Enviar", "UnidadesEnviar");
            dic.Add("Monto Producto a Enviar", "MontoProductoEnviar");
            dic.Add("Operación", "Operacion");
            dic.Add("Motivo", "Reclamo");
            dic.Add("Estado", "EstadoDetalle");
            dic.Add("Motivo Rechazo", "MotivoRechazo");
            dic.Add("Segmento Consultora", "TipoConsultora");
            dic.Add("Indicador Despacho", "TipoDespacho");
            dic.Add("Flete CDR", "FleteDespacho");
            dic.Add("Origen CDR Web", "OrigenCDRWeb");
            Util.ExportToExcel<BECDRWebDetalleReporte>("ReporteCDRWebDetalleExcel", lst.ToList(), dic);
            return View();
        }

        private string CrearEmailReclamoCulminado(BECDRWeb cDRWeb)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);
            var formatoCampania = cDRWeb.CampaniaID.ToString().Substring(0, 4) + "-" + cDRWeb.CampaniaID.ToString().Substring(4, 2);

            htmlTemplate = htmlTemplate.Replace("#FORMATO_NOMBRECOMPLETO#", userData.NombreConsultora);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHACULIMNADO#", cDRWeb.FechaCulminado.Value.ToString("dd/MM/yyyy"));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMEROSOLICITUD#", cDRWeb.CDRWebID.ToString());
            htmlTemplate = htmlTemplate.Replace("#FORMATO_CAMPANIA#", formatoCampania);

            #region Valores de Mensaje Express

            if (!string.IsNullOrEmpty(cDRWeb.MensajeDespacho))
            {
                var templateMensajeExpressPath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_mensaje_express.html";
                string htmlTemplateMensajeExpress = FileManager.GetContenido(templateMensajeExpressPath);
                htmlTemplateMensajeExpress = htmlTemplateMensajeExpress.Replace("#MENSAJE#", cDRWeb.MensajeDespacho);
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

            string htmlDetalle = "";
            foreach (var cDRWebDetalle in cDRWeb.CDRWebDetalle)
            {
                string html = htmlTemplateDetalleBase.Clone().ToString();
                html = html.Replace("#FORMATO_CUV1#", cDRWebDetalle.CUV);

                string templateUrlDetalleOperacionBase =
                    cDRWebDetalle.CodigoOperacion == "C" ? templateDetalleOperacionCanjePath :
                    cDRWebDetalle.CodigoOperacion == "D" ? templateDetalleOperacionDevolucionPath :
                    cDRWebDetalle.CodigoOperacion == "F" ? templateDetalleOperacionFaltantePath :
                    cDRWebDetalle.CodigoOperacion == "G" ? templateDetalleOperacionFaltanteAbonoPath :
                    templateUrlDetalleOperacionTruequePath;

                string htmlTemplateDetalleOperacion = FileManager.GetContenido(templateUrlDetalleOperacionBase);
                string htmlOperacion = htmlTemplateDetalleOperacion.Clone().ToString();

                var precio = decimal.Round(cDRWebDetalle.Precio, 2);
                var precio2 = decimal.Round(cDRWebDetalle.Precio2, 2);
                var simbolo = userData.Simbolo;

                htmlOperacion = htmlOperacion.Replace("#FORMATO_DESCRIPCIONCUV1#", cDRWebDetalle.Descripcion);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_SOLICITUD#", cDRWebDetalle.Solicitud);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_CANTIDAD1#", cDRWebDetalle.Cantidad.ToString());
                htmlOperacion = htmlOperacion.Replace("#FORMATO_CUV2#", cDRWebDetalle.CUV2);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_PRECIO1#", simbolo + " " + precio);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_DESCRIPCIONCUV2#", cDRWebDetalle.Descripcion2);
                htmlOperacion = htmlOperacion.Replace("#FORMATO_CANTIDAD2#", cDRWebDetalle.Cantidad2.ToString());
                htmlOperacion = htmlOperacion.Replace("#FORMATO_PRECIO2#", simbolo + " " + precio2);

                html = html.Replace("#FORMATO_DETALLE_TIPO_OPERACION#", htmlOperacion);
                htmlDetalle += html;
            }
            htmlTemplate = htmlTemplate.Replace("#FORMATO_DETALLECDR#", htmlDetalle);

            #endregion

            return htmlTemplate;
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            PaisID = UserData().PaisID;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ZonaModel> lstZonas = DropDownListZonas(PaisID);
            IEnumerable<RegionModel> lstRegiones = DropDownListRegiones(PaisID);

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
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }
        
        private List<BETablaLogicaDatos> GetListMensajeCDRExpress()
        {
            if (Session[Constantes.ConstSession.CDRExpressMensajes] != null)
            {
                return (List<BETablaLogicaDatos>)Session[Constantes.ConstSession.CDRExpressMensajes];
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
            Session[Constantes.ConstSession.CDRExpressMensajes] = listMensaje;
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO, "");
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
