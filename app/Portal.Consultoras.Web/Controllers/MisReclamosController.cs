using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceCDR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisReclamosController : BaseController
    {
        public ActionResult Index()
        {
            MisReclamosModel model = new MisReclamosModel();
            var listaReclamoModel = new List<CDRWebModel>();            

            using (CDRServiceClient cdr = new CDRServiceClient())
            {
                var beCdrWeb = new BECDRWeb();
                beCdrWeb.ConsultoraID = userData.ConsultoraID;

                var listaReclamo = cdr.GetCDRWeb(userData.PaisID, beCdrWeb);


            }

            return View();
        }

        public ActionResult Reclamo()
        {
            CargarInformacion();
            var model = new MisReclamosModel();
            model.ListaCampania = (List<CampaniaModel>)Session[Constantes.ConstSession.CDRCampanias];
            model.Email = userData.EMail;
            model.Telefono = userData.Celular;

            return View(model);
        }

        private BECDRWebDescripcion ObtenerDescripcion(string tipo)
        {
            tipo = Util.SubStr(tipo, 0);
            tipo = tipo.ToLower();
            var listaDescripcion = CargarDescripcion();
            var desc = listaDescripcion.FirstOrDefault(d => d.Tipo == tipo) ?? new BECDRWebDescripcion();

            desc.Descripcion = Util.SubStr(desc.Descripcion, 0);
            return desc;
        }

        private void CargarInformacion()
        {
            var listaMotivoOperacion = CargarMotivoOperacion();
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            int maxDias = 100;
            if (listaMotivoOperacion.Any())
            {
                maxDias += Int32.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
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
                var entidad = new BECDRWebMotivoOperacion();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    listaMotivoOperacion = sv.GetCDRWebMotivoOperacion(userData.PaisID, entidad).ToList();
                }

                listaMotivoOperacion = listaMotivoOperacion ?? new List<BECDRWebMotivoOperacion>();
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

                if (maxDias <= 0)
                    return new List<BEPedidoWeb>();                

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
                    return (List<BECDRWebDescripcion>)Session[Constantes.ConstSession.CDRDescripcion];
                }

                var lista = new List<BECDRWebDescripcion>();
                var entidad = new BECDRWebDescripcion();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDescripcion(userData.PaisID, entidad).ToList();
                }

                lista = lista ?? new List<BECDRWebDescripcion>();
                lista.Update(d => d.Tipo = d.Tipo.ToLower());
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

                        var lista = pedido.olstBEPedidoWebDetalle.Where(d => d.CUV == model.CUV || model.CUV == "").ToList();
                        if (lista.Any())
                        {
                            pedido.olstBEPedidoWebDetalle = lista.ToArray();
                            listaPedido.Add(pedido);
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

                    var desc = ObtenerDescripcion(item.CDRMotivoReclamo.CodigoReclamo);
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

                    var desc = ObtenerDescripcion(item.CDRTipoOperacion.CodigoOperacion);
                    var add = new BECDRWebMotivoOperacion();
                    add.CDRTipoOperacion = new BECDRTipoOperacion();
                    add.Tipo = item.Tipo;
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
            
            differenceInDays = differenceInDays <= 0 ? 40 : differenceInDays;

            var listaMotivoOperacion = CargarMotivoOperacion();
            var listaFiltro = listaMotivoOperacion.Where(mo => mo.CDRTipoOperacion.NumeroDiasAtrasOperacion >= differenceInDays && differenceInDays > 0).ToList();

            return listaFiltro ?? new List<BECDRWebMotivoOperacion>();
        }

        private bool ValidarRegistro(MisReclamosModel model)
        {
            if (model.Cantidad <= 0)
                return false;

            model.CUV = Util.SubStr(model.CUV, 0);

            if (model.CUV == "")
                return false;

            var listaPedidoFacturados = CargarPedidoCUV(model);

            if (listaPedidoFacturados.Count() != 1)
                return false;

            var pedido = listaPedidoFacturados[0];

            if (pedido.olstBEPedidoWebDetalle == null)
                return false;

            if (pedido.olstBEPedidoWebDetalle.Count() != 1)
                return false;

            var detalle = pedido.olstBEPedidoWebDetalle[0];
            
            var listaCDRDetalle = CargarDetalle(model);
            listaCDRDetalle = listaCDRDetalle.Where(d => d.CUV == detalle.CUV).ToList();

            var cantidad = listaCDRDetalle.Sum(d => d.Cantidad);
            cantidad = detalle.Cantidad - (cantidad + model.Cantidad);

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
            var valid = ValidarRegistro(model);
            return Json(new
            {
                success = valid
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

        public JsonResult BuscarSolucion(MisReclamosModel model)
        {
            model = model ?? new MisReclamosModel();
            var desc = ObtenerDescripcion(model.Tipo);
            model.DescripcionConfirma = desc.Descripcion;
            desc = ObtenerDescripcion(model.Tipo2);
            model.DescripcionConfirma2 = desc.Descripcion;
            model.CUV = Util.SubStr(model.CUV, 0);
            model.CUV2 = Util.SubStr(model.CUV2, 0);
            return Json(new
            {
                success = true,
                message = "",
                detalle = model
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
                if (model.CDRWebID <= 0)
                {
                    return new List<BECDRWebDetalle>();
                }

                var lista = new List<BECDRWebDetalle>();
                var entidad = new BECDRWebDetalle();
                entidad.CDRWebID = model.CDRWebID;
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDetalle(userData.PaisID, entidad).ToList();
                }

                lista = lista ?? new List<BECDRWebDetalle>();
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

        public JsonResult DetalleGuardar(MisReclamosModel model)
        {
            try
            {
                var id = 0;
                model.CUV2 = Util.SubStr(model.CUV2, 0);
                var entidadDetalle = new BECDRWebDetalle();
                entidadDetalle.CDRWebID = model.CDRWebID;
                entidadDetalle.CodigoReclamo = model.Motivo;
                entidadDetalle.CodigoOperacion = model.Operacion;
                entidadDetalle.CUV = model.CUV;
                entidadDetalle.Cantidad = model.Cantidad;
                entidadDetalle.CUV2 = model.CUV2;
                entidadDetalle.Cantidad2 = model.CUV2 == "" ? 0 : model.Cantidad2;

                if (model.CDRWebID <= 0)
                {
                    var entidad = new BECDRWeb();
                    entidad.CampaniaID = model.CampaniaID;
                    entidad.PedidoID = model.PedidoID;
                    entidad.ConsultoraID = Int32.Parse(userData.ConsultoraID.ToString());
                    entidad.CDRWebDetalle = new BECDRWebDetalle[] {entidadDetalle};
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

        public JsonResult DetalleCargar(MisReclamosModel model)
        {
            var lista = CargarDetalle(model);
            return Json(new
            {
                success = true,
                message = "",
                detalle = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DetalleEliminar(MisReclamosModel model)
        {
            var entidadDetalle = new BECDRWebDetalle();
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                model.CDRWebDetalleID = sv.DelCDRWebDetalle(userData.PaisID, entidadDetalle);
            }

            return Json(new
            {
                success = model.CDRWebDetalleID > 0,
                message = model.CDRWebDetalleID > 0 ? "" : "Error, vuelva a intentarlo",
                detalle = model.CDRWebDetalleID
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
