using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            try
            {
                var model = IndexModel();
                if (model.EstadoAccion < 0)
                {
                    return RedirectToAction("Index", "Bienvenida");
                }

                return View(model);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Detalle(int id)
        {
            try
            {
                var model = DetalleModel(id);
                return View(model);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult _Landing(int id)
        {
            try
            {
                return ViewLanding(id);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return PartialView("template-Landing", new RevistaDigitalModel());
            }
        }

        [HttpPost]
        public JsonResult GetProductos(BusquedaProductoModel model)
        {
            try
            {
                if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                {
                    return Json(new
                    {
                        success = false,
                        message = "",
                        lista = new List<ShowRoomOfertaModel>(),
                        cantidadTotal = 0,
                        cantidad = 0
                    });
                }

                var listModel = ConsultarEstrategiasModel("", model.CampaniaID);

                listModel = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();

                int cantidadTotal = listModel.Count;

                var listaFinal = listModel;

                if (model.ListaFiltro != null && model.ListaFiltro.Count > 0)
                {
                    listaFinal = new List<EstrategiaPedidoModel>();
                    var universo = new List<EstrategiaPedidoModel>();
                    int cont = 0, contVal = 0;
                    foreach (var filtro in model.ListaFiltro)
                    {
                        filtro.Valores = filtro.Valores ?? new List<string>();
                        if (!filtro.Valores.Any()) continue;

                        universo = cont == 0 ? listModel : listaFinal;
                        filtro.Tipo = Util.Trim(filtro.Tipo).ToLower();
                        contVal = 0;
                        foreach (var valor in filtro.Valores)
                        {
                            var val = Util.Trim(valor).ToLower();
                            if (val == "" || val == "-")
                            {
                                listaFinal = contVal == 0 ? universo : listaFinal;
                                continue;
                            }

                            if (filtro.Tipo == "marca")
                            {
                                if (contVal <= 0) listaFinal = new List<EstrategiaPedidoModel>();
                                listaFinal.AddRange(universo.Where(p => Util.Trim(p.DescripcionMarca).ToLower() == val));
                            }
                            else if (filtro.Tipo == "precio")
                            {
                                var listaValDet = val.Split(',');
                                var valorDesde = Convert.ToDecimal(listaValDet[0]);
                                var valorHasta = Convert.ToDecimal(listaValDet[1]);

                                if (contVal <= 0) listaFinal = new List<EstrategiaPedidoModel>();
                                listaFinal.AddRange(universo.Where(p => p.Precio2 >= valorDesde && p.Precio2 <= valorHasta));
                            }
                            contVal++;
                        }
                        cont++;
                    }
                }

                if (model.Ordenamiento != null)
                {
                    model.Ordenamiento.Tipo = Util.Trim(model.Ordenamiento.Tipo).ToLower();
                    if (model.Ordenamiento.Tipo == "precio")
                    {
                        switch (model.Ordenamiento.Valor)
                        {
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

                var cantMostrar = 10;
                listaFinal = listaFinal.Skip(model.Limite).Take(cantMostrar).ToList();

                listaFinal.ForEach(p =>
                {
                    p.PuedeAgregar = IsMobile() ? 0 : 1;
                    p.IsMobile = IsMobile() ? 1 : 0;
                    p.DescripcionMarca = IsMobile() ? "" : p.DescripcionMarca;
                });

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

                producto.PuedeAgregar = 1;
                producto.DescripcionMarca = IsMobile() ? "" : producto.DescripcionMarca;

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

        [HttpPost]
        public JsonResult Suscripcion()
        {
            try
            {
                if (!ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion))
                {
                    return Json(new
                    {
                        success = false,
                        message = "Por el momento no está habilitada la suscripción a ÉSIKA PARA MÍ, gracias."
                    }, JsonRequestBehavior.AllowGet);
                }

                if (userData.RevistaDigital.EstadoSuscripcion == 1)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Usted ya está suscrito a ÉSIKA PARA MÍ, gracias."
                    }, JsonRequestBehavior.AllowGet);
                }

                var entidad = new BERevistaDigitalSuscripcion();
                entidad.PaisID = userData.PaisID;
                entidad.CodigoConsultora = userData.CodigoConsultora;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.CodigoZona = userData.CodigoZona;
                entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo;
                entidad.EstadoEnvio = 0;
                entidad.IsoPais = userData.CodigoISO;
                entidad.EMail = userData.EMail;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.RevistaDigitalSuscripcionID = sv.RDSuscripcion(entidad);
                }

                if (entidad.RevistaDigitalSuscripcionID > 0)
                {
                    userData.RevistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(entidad);
                    userData.RevistaDigital.NoVolverMostrar = true;
                    userData.RevistaDigital.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
                    userData.MenuMobile = null;
                }

                SetUserData(userData);
                Session["TipoPopUpMostrar"] = null;

                return Json(new
                {
                    success = userData.RevistaDigital.EstadoSuscripcion > 0,
                    message = userData.RevistaDigital.EstadoSuscripcion > 0 ? "¡Felicitaciones por inscribirte a ÉSIKA PARA MÍ!" : "Ocurrió un error, vuelva a intentarlo.",
                    CodigoMenu = Constantes.MenuCodigo.RevistaDigital
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult Desuscripcion()
        {
            try
            {
                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Lo sentimos no se puede ejecutar la acción, gracias."
                    }, JsonRequestBehavior.AllowGet);
                }

                var entidad = new BERevistaDigitalSuscripcion();
                entidad.PaisID = userData.PaisID;
                entidad.CodigoConsultora = userData.CodigoConsultora;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.CodigoZona = userData.CodigoZona;
                entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.Desactivo;
                entidad.EstadoEnvio = 0;
                entidad.IsoPais = userData.CodigoISO;
                entidad.EMail = userData.EMail;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.RevistaDigitalSuscripcionID = sv.RDDesuscripcion(entidad);
                }

                if (entidad.RevistaDigitalSuscripcionID > 0)
                {
                    userData.RevistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(entidad);
                    userData.RevistaDigital.NoVolverMostrar = true;
                    userData.RevistaDigital.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
                    userData.MenuMobile = null;
                }

                SetUserData(userData);
                Session["TipoPopUpMostrar"] = null;

                return Json(new
                {
                    success = userData.RevistaDigital.EstadoSuscripcion > 0,
                    message = userData.RevistaDigital.EstadoSuscripcion > 0 ? "¡Que pena, usted se desuscribio a ÉSIKA PARA MÍ!" : "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
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
                        userData.RevistaDigital.SuscripcionModel.EstadoRegistro = Constantes.EstadoRDSuscripcion.NoPopUp;
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

        [HttpPost]
        public JsonResult PopupCerrar()
        {
            try
            {
                userData.RevistaDigital.NoVolverMostrar = true;
                userData.RevistaDigital.EstadoSuscripcion = Constantes.EstadoRDSuscripcion.NoPopUp;
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