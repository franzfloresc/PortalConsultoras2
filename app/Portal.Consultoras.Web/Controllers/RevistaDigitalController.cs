using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceRevistaDigital;
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
    public class RevistaDigitalController : BaseEstrategiaController
    {
        public ActionResult Index()
        {
            try
            {
                //if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                //    return RedirectToAction("Index", "Bienvenida");
                
                var model = new RevistaDigitalModel();
                model.NombreUsuario = userData.UsuarioNombre.ToUpper();
                var listaProducto = ConsultarEstrategiasModel();
                using (SACServiceClient svc = new SACServiceClient())
                {
                    model.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
                }

                model.ListaProducto = listaProducto.Where(e => e.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
                var listadoNoLanzamiento = listaProducto.Where(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento && e.CodigoEstrategia != "").ToList() ?? new List<EstrategiaPedidoModel>();

                if (listadoNoLanzamiento.Any())
                {
                    model.PrecioMin = listadoNoLanzamiento.Min(p => p.Precio2);
                    model.PrecioMax = listadoNoLanzamiento.Max(p => p.Precio2);
                }
                if (!model.ListaProducto.Any())
                {
                    model.ListaProducto = listaProducto;
                    model.ListaProducto.Update(p => p.ImgFondoDesktop = "/Content/Images/RevistaDigital/lan-fondo.png");
                }
                model.ListaProducto.Update(p => {
                    p.ImgFondoDesktop = Util.Trim(p.ImgFondoDesktop);
                    p.ImgPrevDesktop = Util.Trim(p.ImgPrevDesktop);
                    p.ImgFichaDesktop = Util.Trim(p.ImgFichaDesktop);
                    p.UrlVideoDesktop = Util.Trim(p.UrlVideoDesktop);
                    p.ImgFondoMobile = Util.Trim(p.ImgFondoMobile);
                    p.ImgFichaMobile = Util.Trim(p.ImgFichaMobile);
                    p.UrlVideoMobile = Util.Trim(p.UrlVideoMobile);
                });

                return View(model);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
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

                if (model.Limite > 0)
                    listaFinal = listaFinal.Take(model.Limite).ToList();
                
                listaFinal.Update(s =>
                {
                    s.ID = s.EstrategiaID;
                    s.Descripcion = Util.SubStrCortarNombre(s.Descripcion, IsMobile() ? 30 : 40);
                    if (s.FlagMostrarImg == 1)
                    {
                        if (s.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                        {
                            if (s.FlagEstrella == 1)
                            {
                                s.ImagenURL = "/Content/Images/oferta-ultimo-minuto.png";
                            }
                        }
                        else if (!(s.TipoEstrategiaImagenMostrar == @Constantes.TipoEstrategia.PackNuevas
                            || s.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.Lanzamiento))
                        {
                            s.ImagenURL = "";
                        }
                    }
                    else
                    {
                        s.ImagenURL = "";
                    }
                });

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

            // Usar este metodo para validadcion extras (aun no esta en uso)
            //var mensaje = "";
            //if (!RevistaDigitalValidar(out mensaje))
            //{
            //    return Json(new
            //    {
            //        success = false,
            //        message = mensaje
            //    }, JsonRequestBehavior.AllowGet);
            //}

            var entidad = new BERevistaDigitalSuscripcion();
            entidad.PaisID = userData.PaisID;
            entidad.CodigoConsultora = userData.CodigoConsultora;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.CodigoZona = userData.CodigoZona;
            entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo;
            entidad.IsoPais = userData.CodigoISO;
            entidad.EMail = userData.EMail;

            using (RevistaDigitalServiceClient sv = new RevistaDigitalServiceClient())
            {
                if (sv.Suscripcion(entidad) > 0)
                {
                    var rds = sv.GetSuscripcion(entidad);
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
                message = userData.RevistaDigital.EstadoSuscripcion > 0 ? "GRACIAS POR SUSCRIBIRSE." : "OCURRIÓ UN ERROR, VUELVA A INTENTARLO."
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

                using (RevistaDigitalServiceClient sv = new RevistaDigitalServiceClient())
                {
                    if (sv.Suscripcion(entidad) > 0)
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