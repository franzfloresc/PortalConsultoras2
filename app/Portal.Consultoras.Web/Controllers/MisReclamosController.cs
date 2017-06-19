using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceCDR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System.ServiceModel;


namespace Portal.Consultoras.Web.Controllers
{
    public class MisReclamosController : BaseController
    {        
        public ActionResult Index()
        {
            if(userData.TieneCDR == 0) return RedirectToAction("Index", "Bienvenida");

            MisReclamosModel model = new MisReclamosModel();
            var listaCDRWebModel = new List<CDRWebModel>();
            try
            {
                using (CDRServiceClient cdr = new CDRServiceClient())
                {
                    var beCdrWeb = new BECDRWeb();
                    beCdrWeb.ConsultoraID = userData.ConsultoraID;

                    var listaReclamo = cdr.GetCDRWeb(userData.PaisID, beCdrWeb).ToList();
                    /*
                    Mapper.CreateMap<BECDRWeb, CDRWebModel>()
                        .ForMember(t => t.CDRWebID, f => f.MapFrom(c => c.CDRWebID))
                        .ForMember(t => t.PedidoID, f => f.MapFrom(c => c.PedidoID))
                        .ForMember(t => t.PedidoNumero, f => f.MapFrom(c => c.PedidoNumero))
                        .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                        .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                        .ForMember(t => t.FechaRegistro, f => f.MapFrom(c => c.FechaRegistro))
                        .ForMember(t => t.Estado, f => f.MapFrom(c => c.Estado))
                        .ForMember(t => t.FechaCulminado, f => f.MapFrom(c => c.FechaCulminado))
                        .ForMember(t => t.Importe, f => f.MapFrom(c => c.Importe))
                        .ForMember(t => t.FechaAtencion, f => f.MapFrom(c => c.FechaAtencion))
                        .ForMember(t => t.CantidadDetalle, f => f.MapFrom(c => c.CantidadDetalle));
                     * */
                    listaCDRWebModel = Mapper.Map<List<BECDRWeb>, List<CDRWebModel>>(listaReclamo);
                }
            }
            catch (Exception ex)
            {
                listaCDRWebModel = new List<CDRWebModel>();
            }
            
            string urlPoliticaCdr = ConfigurationManager.AppSettings.Get("UrlPoliticasCDR") ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.ListaCDRWeb = listaCDRWebModel.FindAll(p => p.CantidadDetalle > 0);
            model.MensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitadaYChatEnLinea();

            ViewBag.TieneCDRExpress = userData.TieneCDRExpress; //EPD-1919
            ViewBag.MensajeCDRExpress = userData.MensajeCDRExpress; //EPD-1919
            ViewBag.MensajeCDRExpressNueva = userData.MensajeCDRExpressNueva; //EPD-1919
            ViewBag.ConsultoraNueva = userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva; //EPD-1919

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
            /*EPD-1339*/
            if (model.ListaCampania.Count <= 1) return RedirectToAction("Index");
            /*EPD-1339*/

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

            string urlPoliticaCdr = ConfigurationManager.AppSettings.Get("UrlPoliticasCDR") ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.Email = userData.EMail;
            model.Telefono = userData.Celular;
            model.MontoMinimo = userData.MontoMinimo;
            
            //EPD-1919
            ViewBag.TieneCDRExpress = userData.TieneCDRExpress;
            ViewBag.MensajeCDRExpress = userData.MensajeCDRExpress;
            ViewBag.MensajeCDRExpressNueva = userData.MensajeCDRExpressNueva;
            ViewBag.EsConsultoraNueva = userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva;

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

        private BECDRWebDescripcion ObtenerDescripcion(string codigoSsic, string tipo)
        {
            codigoSsic = Util.SubStr(codigoSsic, 0);
            //codigoSsic = codigoSsic.ToLower();
            tipo = Util.SubStr(tipo, 0);
            //tipo = tipo.ToLower();
            var listaDescripcion = CargarDescripcion();
            var desc = listaDescripcion.FirstOrDefault(d => d.CodigoSSIC == codigoSsic && d.Tipo == tipo) ?? new BECDRWebDescripcion();

            desc.Descripcion = Util.SubStr(desc.Descripcion, 0);
            return desc;
        }

        private int CumpleRangoCampaniaCDR()
        {
            var listaMotivoOperacion = CargarMotivoOperacion();
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            int maxDias = 0;
            if (listaMotivoOperacion.Any())
            {
                maxDias += int.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
            }

            var listaPedidoFacturados = CargarPedidosFacturados(maxDias);
            return (listaPedidoFacturados.Count > 0) ? 1 : 0;
        }

        private void CargarInformacion()
        {
            Session[Constantes.ConstSession.CDRPedidosFacturado] = null;
            Session[Constantes.ConstSession.CDRWebDetalle] = null;
            Session[Constantes.ConstSession.CDRWeb] = null;

            var listaMotivoOperacion = CargarMotivoOperacion();
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            int maxDias = 0;
            if (listaMotivoOperacion.Any())
            {
                maxDias += int.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
            }

            var listaPedidoFacturados = CargarPedidosFacturados(maxDias);

            var listaCampanias = new List<CampaniaModel>();
            var campania = new CampaniaModel();
            campania.CampaniaID = 0;
            campania.NombreCorto = "¿En qué campaña lo solicitaste?";
            listaCampanias.Add(campania);
            foreach (var facturado in listaPedidoFacturados)
	        {
                var existe = listaCampanias.Where(c => c.CampaniaID == facturado.CampaniaID) ?? new List<CampaniaModel>();
                if (!existe.Any())
                {
                    campania = new CampaniaModel();
                    campania.CampaniaID = facturado.CampaniaID;
                    campania.NombreCorto = facturado.CampaniaID.ToString();
                    listaCampanias.Add(campania);
                }
	        }

            Session[Constantes.ConstSession.CDRCampanias] = listaCampanias;

            CargarParametriaCdr();
            CargarCdrWebDatos();
        }

        private List<BECDRWebMotivoOperacion> CargarMotivoOperacion()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRMotivoOperacion] != null)
                {
                    return (List<BECDRWebMotivoOperacion>)Session[Constantes.ConstSession.CDRMotivoOperacion];
                }

                var listaMotivoOperacion = new List<BECDRWebMotivoOperacion>();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    listaMotivoOperacion = sv.GetCDRWebMotivoOperacion(userData.PaisID, new BECDRWebMotivoOperacion()).ToList();
                }

                //EPD-2038
                //var lstCDRWebTipoOperacion = new List<BECDRTipoOperacion>();
                //using (CDRServiceClient sv = new CDRServiceClient())
                //{
                //    lstCDRWebTipoOperacion = sv.GetCDRWebTipoOperacion(userData.PaisID).ToList();
                //}
                //foreach (var item in lstCDRWebTipoOperacion)
                //{
                //    listaMotivoOperacion.Where(mo => item.CodigoOperacion.Contains(mo.CodigoOperacion))
                //        .Update(mo =>
                //        {
                //            mo.CDRTipoOperacion.NumeroDiasAtrasOperacion = Math.Min(item.NumeroDiasAtrasOperacion, mo.CDRTipoOperacion.NumeroDiasAtrasOperacion);
                //        });
                //}
                //fin

                int diasFaltantes = 0;
                BECDRWebDatos cDRWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.ValidacionDiasFaltante);
                if(cDRWebDatos != null) Int32.TryParse(cDRWebDatos.Valor, out diasFaltantes);

                if (diasFaltantes > 0)
                {
                    List<string> operacionFaltanteList = new List<string> { "F", "G" };
                    listaMotivoOperacion.Where(mo => operacionFaltanteList.Contains(mo.CodigoOperacion))
                        .Update(mo => {
                            mo.CDRTipoOperacion.NumeroDiasAtrasOperacion = Math.Min(diasFaltantes, mo.CDRTipoOperacion.NumeroDiasAtrasOperacion);
                        });
                }
                Session[Constantes.ConstSession.CDRMotivoOperacion] = listaMotivoOperacion;
                return listaMotivoOperacion;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRMotivoOperacion] = null;
                return new List<BECDRWebMotivoOperacion>();
            }
        }

        private List<BEPedidoWeb> CargarPedidosFacturados(int maxDias = 0)
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRPedidosFacturado] != null)
                {
                    return (List<BEPedidoWeb>)Session[Constantes.ConstSession.CDRPedidosFacturado];
                }

                if (maxDias <= 0) return new List<BEPedidoWeb>();                

                var listaPedidoFacturados = new List<BEPedidoWeb>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaPedidoFacturados = sv.GetPedidosFacturadoSegunDias(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, maxDias).ToList();
                }                
                
                listaPedidoFacturados = listaPedidoFacturados ?? new List<BEPedidoWeb>();
                Session[Constantes.ConstSession.CDRPedidosFacturado] = listaPedidoFacturados;
                return listaPedidoFacturados;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRPedidosFacturado] = null;
                return new List<BEPedidoWeb>();
            }
        }

        private List<BECDRWebDescripcion> CargarDescripcion()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRDescripcion] != null)
                {
                    var listaDescripcion = (List<BECDRWebDescripcion>)Session[Constantes.ConstSession.CDRDescripcion];
                    if (listaDescripcion.Count > 0)
                        return listaDescripcion;
                }

                var lista = new List<BECDRWebDescripcion>();
                var entidad = new BECDRWebDescripcion();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDescripcion(userData.PaisID, entidad).ToList();
                }

                lista = lista ?? new List<BECDRWebDescripcion>();
                //lista.Update(d => d.Tipo = d.Tipo.ToLower());
                Session[Constantes.ConstSession.CDRDescripcion] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRDescripcion] = null;
                return new List<BECDRWebDescripcion>();
            }
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

        private List<BECDRMotivoReclamo> CargarMotivo(MisReclamosModel model)
        {
            var listaRetorno = new List<BECDRMotivoReclamo>();
            try
            {
                model.Operacion = Util.SubStr(model.Operacion, 0);
                var listaFiltro = CargarMotivoOperacionPorDias(model);
                foreach (var item in listaFiltro)
                {
                    if (item.CodigoOperacion != model.Operacion && model.Operacion != "")
                        continue;

                    if (listaRetorno.Any(r => r.CodigoReclamo == item.CodigoReclamo))
                        continue;

                    var desc = ObtenerDescripcion(item.CDRMotivoReclamo.CodigoReclamo, Constantes.TipoMensajeCDR.Motivo);
                    var add = new BECDRMotivoReclamo();
                    add.CodigoReclamo = item.CodigoReclamo;
                    add.DescripcionReclamo = desc.Descripcion;
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
                    //add.Tipo = item.Tipo;
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

        private List<BECDRWebMotivoOperacion> CargarMotivoOperacionPorDias(MisReclamosModel model)
        {
            var listaPedidoFacturado = CargarPedidosFacturados();
            var pedido = listaPedidoFacturado.FirstOrDefault(p => p.PedidoID == model.PedidoID) ?? new BEPedidoWeb();
            DateTime fechaSys = userData.FechaActualPais.Date;
            DateTime fechaFinCampania = pedido.FechaRegistro.Date;
            TimeSpan diferencia = fechaSys - fechaFinCampania;
            int differenceInDays = diferencia.Days;
            //Para Pruebas
            //differenceInDays = 30;

            if (differenceInDays <= 0) return new List<BECDRWebMotivoOperacion>();

            var listaMotivoOperacion = CargarMotivoOperacion();
            var listaFiltro = listaMotivoOperacion.Where(mo => mo.CDRTipoOperacion.NumeroDiasAtrasOperacion >= differenceInDays).ToList();
            return listaFiltro.OrderBy(p => p.Prioridad).ToList();
        }

        private bool TieneDetalleFueraFecha(BECDRWeb cdrWeb, MisReclamosModel model)
        {
            var operacionValidaList = CargarMotivoOperacionPorDias(model);
            return cdrWeb.CDRWebDetalle.Any(detalle => {
                return !operacionValidaList.Any(operacion => operacion.CodigoOperacion == detalle.CodigoOperacion);
            });
        }

        private List<BECDRParametria> CargarParametriaCdr()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRParametria] != null)
                {
                    var listaDescripcion = (List<BECDRParametria>)Session[Constantes.ConstSession.CDRParametria];
                    if (listaDescripcion.Count > 0)
                        return listaDescripcion;
                }

                var lista = new List<BECDRParametria>();
                var entidad = new BECDRParametria();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRParametria(userData.PaisID, entidad).ToList();
                }
                
                Session[Constantes.ConstSession.CDRParametria] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRParametria] = null;
                return new List<BECDRParametria>();
            }
        }

        private List<BECDRWebDatos> CargarCdrWebDatos()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRWebDatos] != null)
                {
                    var listacdrWebDatos = (List<BECDRWebDatos>)Session[Constantes.ConstSession.CDRWebDatos];
                    if (listacdrWebDatos.Count > 0)
                        return listacdrWebDatos;
                }

                var lista = new List<BECDRWebDatos>();
                var entidad = new BECDRWebDatos();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDatos(userData.PaisID, entidad).ToList();
                }

                Session[Constantes.ConstSession.CDRWebDatos] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRWebDatos] = null;
                return new List<BECDRWebDatos>();
            }
        }

        private BECDRWebDatos ObtenerCdrWebDatosByCodigo(string codigo)
        {
            return CargarCdrWebDatos().FirstOrDefault(p => p.Codigo == codigo);
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

            if (listaPedidoFacturados.Count() == 0)
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

            /*para prueba*/
            //listaPedidoFacturados.AddRange(listaPedidoFacturados);
            
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
            catch (Exception ex) { }

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
            catch (Exception ex) { }

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
            //desc = ObtenerDescripcion(model.EstadoSsic2, Constantes.TipoMensajeCDR.Propuesta);
            //model.DescripcionConfirma2 = desc.Descripcion;
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

        private List<BECDRWebDetalle> CargarDetalle(MisReclamosModel model)
        {

            try
            {
                if (Session[Constantes.ConstSession.CDRWebDetalle] != null)
                {
                    return (List<BECDRWebDetalle>)Session[Constantes.ConstSession.CDRWebDetalle];
                }

                model = model ?? new MisReclamosModel();
                //if (model.CDRWebID <= 0)
                //{
                //    return new List<BECDRWebDetalle>();
                //}

                var lista = new List<BECDRWebDetalle>();
                var entidad = new BECDRWebDetalle();
                entidad.CDRWebID = model.CDRWebID;
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDetalle(userData.PaisID, entidad, model.PedidoID).ToList();
                }

                lista = lista ?? new List<BECDRWebDetalle>();

                lista.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado).Descripcion);
                lista.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado).Descripcion);

                Session[Constantes.ConstSession.CDRWebDetalle] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRWebDetalle] = null;
                return new List<BECDRWebDetalle>();
            }
        }

        private bool ValidarDetalleGuardar(ref MisReclamosModel modelOri)
        {
            var rpta = true;
            var model = modelOri ?? new MisReclamosModel();
            model.CUV = Util.SubStr(model.CUV, 0);
            model.CUV2 = Util.SubStr(model.CUV2, 0);

            string mensajeError = "";
            var valida = ValidarRegistro(model, out mensajeError);

            modelOri = model;
            if (!valida)
                return false;

            var cdrWebs = CargarBECDRWeb(model);
            if (cdrWebs.Count() != 1)
                return rpta;
            
            var cdrWeb = cdrWebs[0];

            if (cdrWeb.CDRWebID == -1 && model.Accion != "I")
                return false;

            model.CDRWebID = cdrWeb.CDRWebID;

            var lista = CargarDetalle(model);

            if (model.Accion == "I")
            {
                rpta = lista.Any(d => d.CDRWebID == model.CDRWebID && d.CUV == model.CUV && d.CodigoOperacion == model.Operacion) ? false : rpta;
            }
            else if (model.Accion == "U")
            {
                
                rpta = lista.Any(d => d.CDRWebID == model.CDRWebID && d.CUV == model.CUV && d.CodigoOperacion == model.Operacion) ? rpta : false;
            }

            if (model.Accion == "")
                rpta = false;

            modelOri = model;
            return rpta;
        }

        private List<BECDRWeb> CargarBECDRWeb(MisReclamosModel model)
        {
            var entidadLista = new List<BECDRWeb>();
            try
            {
                if (Session[Constantes.ConstSession.CDRWeb] != null)
                {
                    return (List<BECDRWeb>)Session[Constantes.ConstSession.CDRWeb];
                }

                //if (model.PedidoID * model.CampaniaID <= 0)
                //    return entidadLista;

                var entidad = new BECDRWeb();
                entidad.CampaniaID = model.CampaniaID;
                entidad.PedidoID = model.PedidoID;
                entidad.ConsultoraID = Int32.Parse(userData.ConsultoraID.ToString());

                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    entidadLista = sv.GetCDRWeb(userData.PaisID, entidad).ToList();
                }

                Session[Constantes.ConstSession.CDRWeb] = null;
                if (entidadLista.Count() == 1)
                {
                    Session[Constantes.ConstSession.CDRWeb] = entidadLista;
                }

                return entidadLista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRWeb] = null;
                entidadLista = new List<BECDRWeb>();
                return entidadLista;
            }
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
                    entidad.CDRWebDetalle = new BECDRWebDetalle[] {entidadDetalle};

                    //EPD-1919 INICIO UNCOMMENTEDDICC
                    entidad.TipoDespacho = model.TipoDespacho; 
                    entidad.FleteDespacho = model.FleteDespacho;

                    if (userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva)
                        entidad.FleteDespacho = 0.00M;

                    entidad.MensajeDespacho = model.MensajeDespacho;
                    //EPD-1919 FIN

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

        public bool EvaluarVisibilidadCDRExpress(int cdrWebId, int pedidoId)
        {
            bool rpta = false;
            if (userData.TieneCDRExpress &&
                CargarDetalle(new MisReclamosModel
                {
                    CDRWebID = cdrWebId,
                    PedidoID = pedidoId
                }).FindAll(x => x.CodigoOperacion == Constantes.CodigoOperacionCDR.Canje ||
                                x.CodigoOperacion == Constantes.CodigoOperacionCDR.Trueque).Count() > 0)
                return true;
            return rpta;
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
                cantobservado = lista.FindAll(x => x.Estado == Constantes.EstadoCDRWeb.Observado).Count(),
                cantaprobado = lista.FindAll(x => x.Estado == Constantes.EstadoCDRWeb.Aceptado).Count(),
                cantProductosCambiados = lista.FindAll(x => x.CodigoOperacion == Constantes.CodigoOperacionCDR.Canje ||
                                                 x.CodigoOperacion == Constantes.CodigoOperacionCDR.Trueque).Count(), //EPD-1919
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
                    if(cdrWeb == null) return ErrorJson("Error al buscar reclamo.", true);
                    cdrWeb.CDRWebDetalle = sv.GetCDRWebDetalle(userData.PaisID, new BECDRWebDetalle { CDRWebID = cdrWeb.CDRWebID }, cdrWeb.PedidoID);
                    if(TieneDetalleFueraFecha(cdrWeb, model)) return ErrorJson(Constantes.CdrWebMensajes.FueraDeFecha + " " + Constantes.CdrWebMensajes.ContactateChatEnLinea, true);
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
                        MensajeDespacho = model.MensajeDespacho
                    }; //EPD-1919

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

                string contenidoMailCulminado = CrearEmailReclamoCulminado(cDRWebMailConfirmacion);
                Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "CDR: EN EVALUACIÓN", contenidoMailCulminado, true, userData.NombreConsultora);

                //Proceso de envio de correo en caso el email sea nuevo.
                if (SiNoEmail == 1)
                {
                    string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
                    string param_querystring = Util.EncriptarQueryString(parametros);
                    string cadena = "<br /><br /> Estimada consultora " + userData.NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                     "<br /> <a href='" + Util.GetUrlHost(HttpContext.Request) + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'>aquí</a><br/><br/>Belcorp";//2442
                    Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", model.Email, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, userData.NombreConsultora);
                    
                    return Json(new
                    {
                        Cantidad = SiNoEmail,
                        success = true,
                        message = "Sus datos se actualizaron correctamente.\n Se ha enviado un correo electrónico de verificación a la dirección ingresada.",
                        extra = "",
                        cdrWeb = cDRWebMailConfirmacion
                    }, JsonRequestBehavior.AllowGet);
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

            var montoProductos = listaByCodigoOperacion.Sum(p => p.Cantidad*p.Precio);

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
                //TiposConsultora = DropDownListEstadoActividad(PaisId),
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
                entidad.TipoConsultora = TipoConsultora;//EPD-2582
                

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

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
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
                        case "MotivoRechazo":
                            items = lst.OrderBy(x => x.MotivoRechazo);
                            break;

                        //EPD 2582 INICIO
                        case "TipoConsultora":
                            items = lst.OrderBy(x => x.TipoConsultora);
                            break;

                        case "TipoDespacho":
                            items = lst.OrderBy(x => x.TipoDespacho);
                            break;

                        case "FleteDespacho":
                            items = lst.OrderBy(x => x.FleteDespacho);
                            break;
                            //EPD 2582 FIN

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


                        //EPD-2582 INICIO
                        case "TipoConsultora":
                            items = lst.OrderByDescending(x => x.TipoConsultora);
                            break;

                        case "TipoDespacho":
                            items = lst.OrderByDescending(x => x.TipoDespacho);
                            break;

                        case "FleteDespacho":
                            items = lst.OrderByDescending(x => x.FleteDespacho);
                            break;
                            //EPD-2582 FIN

                    }
                }
                #endregion
                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                pag = Util.PaginadorGenerico(grid, lst);
                // Creamos la estructura

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

                                   //EPD-2582 INICIO
                                   (a.TipoConsultora ?? string.Empty).ToString(),
                                   (a.TipoDespacho??string.Empty).ToString(),
                                   a.FleteDespacho.ToString()
                                   //EPD-2582 FIN

                                   //Convert.ToDateTime(a.FechaFinDD.ToString()).ToShortDateString(),
                                   //a.ZonaID.ToString()
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
            entidad.TipoConsultora = TipoConsultora;//EPD-2582

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
            //EPD-2598 INICIo
            dic.Add("Segmento Consultora", "TipoConsultora");
            dic.Add("Indicador Despacho", "TipoDespacho");
            dic.Add("Flete CDR", "FleteDespacho");
            //EPD-2598 FIn
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

            if (EvaluarVisibilidadCDRExpress(cDRWeb.CDRWebID, cDRWeb.PedidoID))
            {
                string _tipodespacho = cDRWeb.TipoDespacho == false ? "Despacho con su Pedido" : "Despacho Express";
                _tipodespacho = "Tipo de Despacho: <span><b>" + _tipodespacho + "</b></span>";
                htmlTemplate = htmlTemplate.Replace("#TIPO_DESPACHO#", _tipodespacho);
            }
            else
            {
                htmlTemplate = htmlTemplate.Replace("#TIPO_DESPACHO#", "");
            }

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

        //EDP-1919 INICIO
        public JsonResult BuscarCostoEnvio()
        {

            //Get information from SICC using userData info
            string mensajeCostoEnvio = string.Empty;
            string mensajeNuevaConsultora = string.Empty;
            decimal costoFlete = 159.99M;
            string monedaFlete = "S/.";
            //Get information from SICC 
            //Validacion Nueva Consultora
            if (userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva)
            {
                mensajeNuevaConsultora = userData.MensajeCDRExpressNueva;                using (CDRServiceClient cdr = new CDRServiceClient())
                {
                    var flete = cdr.GetMontoFletePorZonaId(userData.PaisID, new BECDRWeb() { ZonaID = userData.ZonaID });
                    costoFlete = flete.FleteDespacho;
                    monedaFlete = userData.Simbolo; //Sobreescribimos la moneda por que ya se obtiene del userData EPD-1919
                }            }            
            return Json(new
            {
                mensajeCostoEnvio = string.Format(string.IsNullOrEmpty(userData.MensajeCDRExpress) ? string.Empty : userData.MensajeCDRExpress,
                                                  monedaFlete,
                                                  costoFlete.ToString("###,###,###.00")),
                mensajeNuevaConsultora = mensajeNuevaConsultora,
                costoFlete = costoFlete
            }, JsonRequestBehavior.AllowGet);
        }
        //EDP-1919 FIN

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            //PaisID = 11;
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
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private string MensajeGestionCdrInhabilitadaYChatEnLinea()
        {
            string mensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitada();
            if (string.IsNullOrEmpty(mensajeGestionCdrInhabilitada)) return mensajeGestionCdrInhabilitada;
            return mensajeGestionCdrInhabilitada + " " + Constantes.CdrWebMensajes.ContactateChatEnLinea;
        }

        private string MensajeGestionCdrInhabilitada()
        {
            if (userData.EsCDRWebZonaValida == 0) return Constantes.CdrWebMensajes.ZonaBloqueada;
            if(userData.IndicadorBloqueoCDR == 1) return Constantes.CdrWebMensajes.ConsultoraBloqueada;
            if (CumpleRangoCampaniaCDR() == 0) return Constantes.CdrWebMensajes.SinPedidosDisponibles;

            int diasFaltantes = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            if (diasFaltantes == 0) return Constantes.CdrWebMensajes.FueraDeFecha;

            int cDRDiasAntesFacturacion = 0;
            BECDRWebDatos cDRWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.DiasAntesFacturacion);
            if(cDRWebDatos != null) Int32.TryParse(cDRWebDatos.Valor, out cDRDiasAntesFacturacion);
            if (diasFaltantes <= cDRDiasAntesFacturacion) return Constantes.CdrWebMensajes.FueraDeFecha;

            return string.Empty;
        }
    }
}
