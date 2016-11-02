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

            var maxDias = 60;

            var listaPedidoFacturados = CargarPedidosFacturados(maxDias);

            var listaCampanias = new List<CampaniaModel>();
            foreach (var facturado in listaPedidoFacturados)
	        {
                var existe = listaCampanias.Where(c => c.CampaniaID == facturado.CampaniaID) ?? new List<CampaniaModel>();
                if (!existe.Any())
                {
                    listaCampanias.Add((CampaniaModel)(Object)facturado);
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
                    //listaPedidoFacturados = sv.GetPedidosFacturadoSegunDias(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, maxDias).ToList();
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

        private List<Campo> CargarMotivo(MisReclamosModel model)
        {
            try
            {
                //var listaCampania = (List<CampaniaModel>)Session[Constantes.ConstSession.CDRCampanias];
                //var campania = listaCampania.FirstOrDefault(c => c.CampaniaID == model.CampaniaID) ?? new CampaniaModel();

                var listaPedidoFacturado = CargarPedidosFacturados();
                var pedido = listaPedidoFacturado.FirstOrDefault(p => p.PedidoID == model.PedidoID) ?? new BEPedidoWeb();
                DateTime fechaSys = userData.FechaActualPais.Date;
                DateTime fechaFinCampania = pedido.FechaRegistro.Date;
                TimeSpan diferencia = fechaSys - fechaFinCampania;
                int differenceInDays = diferencia.Days;

                if (differenceInDays <= 0)
                    return new List<Campo>();

                var listaRetorno = new List<Campo>();
                var listaMotivoOperacion = CargarMotivoOperacion();
                var listaFiltro = listaMotivoOperacion.Where(mo => mo.CDROperacion.Dias >= differenceInDays).ToList();
                foreach (var item in listaFiltro)
                {
                    if (listaRetorno.Any(r => r.Campoid == item.MotivoCDRID))
                        continue;

                    var desc = ObtenerDescripcion(item.CDRMotivo.Tipo);
                    var add = new Campo();
                    add.Campoid = item.MotivoCDRID;
                    add.Nombre = desc.Descripcion;
                    listaRetorno.Add(add);
                }

                return listaRetorno;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new List<Campo>();
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

        private List<Campo> CargarOperacion(MisReclamosModel model)
        {
            try
            {
                var listaPedidoFacturado = CargarPedidosFacturados();
                var pedido = listaPedidoFacturado.FirstOrDefault(p => p.PedidoID == model.PedidoID) ?? new BEPedidoWeb();
                DateTime fechaSys = userData.FechaActualPais.Date;
                DateTime fechaFinCampania = pedido.FechaRegistro.Date;
                TimeSpan diferencia = fechaSys - fechaFinCampania;
                int differenceInDays = diferencia.Days;

                if (differenceInDays <= 0)
                    return new List<Campo>();

                var listaRetorno = new List<Campo>();
                var listaMotivoOperacion = CargarMotivoOperacion();
                var listaFiltro = listaMotivoOperacion.Where(mo => mo.CDROperacion.Dias >= differenceInDays).ToList();
                foreach (var item in listaFiltro)
                {
                    if (item.MotivoCDRID != model.Motivo && model.Motivo > 0)
                        continue;

                    if (listaRetorno.Any(r => r.Campoid == item.OperacionCDRID))
                        continue;

                    //var desc = ObtenerDescripcion(item.CDROperacion.Tipo);
                    //var add = new Campo();
                    //add.Campoid = item.MotivoCDRID;
                    //add.Nombre = desc.Descripcion;
                    //listaRetorno.Add(add);
                }

                return listaRetorno;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new List<Campo>();
            }
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
            cantidad = cantidad - model.Cantidad;

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
            model.Operacion = 0;
            var lista = CargarOperacion(model);
            return Json(new
            {
                success = true,
                message = "",
                detalle = lista
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
            if (model.CDRWebID <= 0)
            {
                var CDRWebID = 0;
                var entidad = new BECDRWeb();
                entidad.CampaniaID = model.CampaniaID;
                entidad.PedidoID = model.PedidoID;
                entidad.ConsultoraID = Int32.Parse(userData.ConsultoraID.ToString());
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    CDRWebID = sv.InsCDRWeb(userData.PaisID, entidad);
                }
                model.CDRWebID = CDRWebID;
            }

            if (model.CDRWebID <= 0)
            {
                return Json(new
                {
                    success = false,
                    message = "Error, vuelva a intentarlo"
                }, JsonRequestBehavior.AllowGet);
            }

            var entidadDetalle = new BECDRWebDetalle();
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                model.CDRWebDetalleID = sv.InsCDRWebDetalle(userData.PaisID, entidadDetalle);
            }

            return Json(new
            {
                success = model.CDRWebDetalleID > 0,
                message = model.CDRWebDetalleID > 0 ? "" : "Error, vuelva a intentarlo",
                detalle = model.CDRWebDetalleID
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DetalleCargar(MisReclamosModel model)
        {
            return Json(new
            {
                success = true,
                message = "",
                pedido = ""
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
