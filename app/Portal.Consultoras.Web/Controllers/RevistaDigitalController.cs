using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            try
            {
                //if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                //    return RedirectToAction("Index", "Bienvenida");

                var model = IndexModel();

                return View(model);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Detalle()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Inscripcion()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigitalSuscripcion))
                return RedirectToAction("Index", "Bienvenida");

            return View();
        }

        private bool RevistaDigitalValidar(out string respuesta)
        {
            var activo = true;

            //using (PedidoServiceClient sv = new PedidoServiceClient())
            //{
            //    listaShowRoomCPC = sv.GetProductosCompraPorCompra(userData.PaisID, eventoId, campaniaId).ToList();
            //}

            respuesta = "";

            return activo;
        }

        [HttpPost]
        public JsonResult GetProductos(BusquedaProductoModel model)
        {
            try
            {
                //if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                //{
                //    return Json(new
                //    {
                //        success = false,
                //        message = "",
                //        lista = new List<ShowRoomOfertaModel>(),
                //        cantidadTotal = 0,
                //        cantidad = 0
                //    });
                //}

                var listaFinal = new List<EstrategiaPedidoModel>();
                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
                var listModel = ConsultarEstrategiasModel("");

                listModel = listModel.Where(e=>e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();

                int cantidadTotal = listModel.Count;

                listaFinal = listModel;

                if (model.ListaFiltro != null && model.ListaFiltro.Count > 0)
                {
                    //var filtroCategoria = model.ListaFiltro.FirstOrDefault(p => p.Tipo == Constantes.ShowRoomTipoFiltro.Categoria);
                    //if (filtroCategoria != null)
                    //{
                    //    var arrayCategoria = filtroCategoria.Valores.ToArray();
                    //    listaFinal = listaFinal.Where(p => arrayCategoria.Contains(p.CodigoCategoria)).ToList();
                    //}

                    var filtroRangoPrecio = model.ListaFiltro.FirstOrDefault(p => p.Tipo == Constantes.ShowRoomTipoFiltro.RangoPrecios);
                    if (filtroRangoPrecio != null)
                    {
                        var valorDesde = filtroRangoPrecio.Valores[0];
                        var valorHasta = filtroRangoPrecio.Valores[1];
                        listaFinal = listaFinal.Where(p => p.Precio2 >= Convert.ToDecimal(valorDesde)
                                     && p.Precio2 <= Convert.ToDecimal(valorHasta)).ToList();
                    }
                }

                if (model.Ordenamiento != null)
                {
                    if (model.Ordenamiento.Tipo == Constantes.ShowRoomTipoOrdenamiento.Precio)
                    {
                        switch (model.Ordenamiento.Valor)
                        {
                            case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido:
                                listaFinal = listaFinal.OrderBy(p => p.Orden).ToList();
                                break;
                            case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor:
                                listaFinal = listaFinal.OrderBy(p => p.Precio2).ToList();
                                break;
                            case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor:
                                listaFinal = listaFinal.OrderByDescending(p => p.Precio2).ToList();
                                break;
                            default:
                                listaFinal = listaFinal.OrderBy(p => p.Orden).ToList();
                                break;
                        }
                    }

                }
                
                int cantidad = listaFinal.Count;

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    lista = listaFinal,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidad
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los productos",
                    data = ""
                });
            }
        }
        
        [HttpPost]
        public JsonResult GetProductoDetalle(int id)
        {
            try
            {
                var listaFinal = ConsultarEstrategiasModel("") ?? new List<EstrategiaPedidoModel>();
                var producto = listaFinal.FirstOrDefault(e => e.EstrategiaID == id) ?? new EstrategiaPedidoModel();
                
                return Json(new
                {
                    success = producto.EstrategiaID > 0,
                    message = producto.EstrategiaID > 0 ? "Ok" : "Error al cargar el producto",
                    lista = producto
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al cargar el producto",
                    data = ""
                });
            }
        }

        [HttpGet]
        public JsonResult Suscripcion()
        {
            if (userData.RevistaDigital.EstadoSuscripcion == 1)
            {
                return Json(new
                {
                    success = false,
                    message = "USTED YA ESTÁ SUSCRITO, GRACIAS."
                }, JsonRequestBehavior.AllowGet);
            }
            
            var entidad = new BERevistaDigitalSuscripcion();
            entidad.PaisID = userData.PaisID;
            entidad.CodigoConsultora = userData.CodigoConsultora;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.CodigoZona = userData.CodigoZona;
            entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo;
            entidad.IsoPais = userData.CodigoISO;
            entidad.EMail = userData.EMail;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                if (sv.RDSuscripcion(entidad) > 0)
                {
                    var rds = sv.RDGetSuscripcion(entidad);
                    userData.RevistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(rds);
                    userData.RevistaDigital.NoVolverMostrar = true;
                    userData.RevistaDigital.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
                }
            }

            SetUserData(userData);
            Session["TipoPopUpMostrar"] = null;

            return Json(new
            {
                success = userData.RevistaDigital.EstadoSuscripcion > 0,
                message = userData.RevistaDigital.EstadoSuscripcion > 0 ? "¡Felicitaciones por inscribirte a ÉSIKA PARA MÍ!" : "OCURRIÓ UN ERROR, VUELVA A INTENTARLO."
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult PopupNoVolverMostrar()
        {
            try
            {
                var entidad = new BERevistaDigitalSuscripcion();
                entidad.PaisID = userData.PaisID;
                entidad.CodigoConsultora = userData.CodigoConsultora;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.CodigoZona = userData.CodigoZona;
                entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.NoPopUp;
                entidad.IsoPais = userData.CodigoISO;
                entidad.EMail = userData.EMail;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    if (sv.RDSuscripcion(entidad) > 0)
                    {
                        userData.RevistaDigital.NoVolverMostrar = true;
                        userData.RevistaDigital.EstadoSuscripcion = Constantes.EstadoRDSuscripcion.NoPopUp;
                    }
                }
                SetUserData(userData);
                Session["TipoPopUpMostrar"] = null;

                return Json(new
                {
                    success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (System.Exception)
            {
                return Json(new
                {
                    success = false,
                    message = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}