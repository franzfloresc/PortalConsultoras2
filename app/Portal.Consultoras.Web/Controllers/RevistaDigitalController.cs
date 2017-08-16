using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
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
                return IndexModel();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult GuardarProductoTemporal(EstrategiaPedidoModel modelo)
        {
            Session[Constantes.SessionNames.ProductoTemporal] = modelo;

            return Json(new
            {
                success = true
            }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult Detalle(string cuv, int campaniaId)
        {
            try
            {
                var modelo = (EstrategiaPedidoModel)Session[Constantes.SessionNames.ProductoTemporal];

                if (modelo == null || modelo.ID == 0)
                {
                    List <BEEstrategia> listaEstrategiaPedidoModel = (List<BEEstrategia>)Session[Constantes.SessionNames.ListaEstrategia];
                    modelo = ConsultarEstrategiasModelFormato(listaEstrategiaPedidoModel.Where(x => x.CUV2 == cuv).ToList()).FirstOrDefault();

                }
                return DetalleModel(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "RevistaDigital");
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

        public ActionResult MensajeBloqueado()
        {
            try
            {
                return PartialView("template-mensaje-bloqueado", MensajeProductoBloqueado());
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return PartialView("template-mensaje-bloqueado", new MensajeProductoBloqueadoModel());
        }

        [HttpPost]
        public JsonResult GetProductos(BusquedaProductoModel model)
        {
            try
            {
                if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital) || EsCampaniaFalsa(model.CampaniaID))
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

                ViewBag.EsMobile = model.IsMobile ? 2 : 1;

                var palanca = model.ValorOpcional == Constantes.TipoEstrategiaCodigo.OfertaParaTi ? "" : Constantes.TipoEstrategiaCodigo.RevistaDigital;

                var listModel = ConsultarEstrategiasModel("", model.CampaniaID, palanca);

                var listModelLan = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();
                listModel = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();
                
                int cantidadTotal = listModel.Count;

                //var cantMostrar = 10;
                //listModel = listModel.Skip(model.CantMostrados).Take(cantMostrar).ToList();

                listModel.ForEach(p =>
                {
                    p.PuedeAgregar = IsMobile() ? 0 : 1;
                    p.IsMobile = IsMobile() ? 1 : 0;
                });

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    listaLan = listModelLan,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
                    campaniaId = model.CampaniaID
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
        public JsonResult GetProductoDetalle(int id, int campaniaId)
        {
            try
            {
                if (EsCampaniaFalsa(campaniaId))
                {
                    return Json(new
                    {
                        success = false,
                        message = "",
                        lista = new EstrategiaPedidoModel()
                    });
                }

                var listaFinal = ConsultarEstrategiasModel("", campaniaId, Constantes.TipoEstrategiaCodigo.RevistaDigital);
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
                if (!userData.RevistaDigital.TieneRDC)
                {
                    if (!userData.RevistaDigital.TieneRDS)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Por el momento no está habilitada la suscripción a ÉSIKA PARA MÍ, gracias."
                        }, JsonRequestBehavior.AllowGet);

                    }
                }

                if (userData.RevistaDigital.EstadoSuscripcion == 1)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Usted ya está suscrito a ÉSIKA PARA MÍ, gracias."
                    }, JsonRequestBehavior.AllowGet);
                }

                var diasAntesFactura = userData.RevistaDigital.DiasAntesFacturaHoy;
                var diasFaltanFactura = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
                if (diasFaltanFactura <= -1 * diasAntesFactura)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Lo sentimos no puede suscribirse, porque " + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ") + " es cierre de campaña."
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
                    userData.Menu = null;
                }

                SetUserData(userData);

                return Json(new
                {
                    success = userData.RevistaDigital.EstadoSuscripcion > 0,
                    message = userData.RevistaDigital.EstadoSuscripcion > 0 ? "" : "Ocurrió un error, vuelva a intentarlo.",
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

                var diasAntesFactura = userData.RevistaDigital.DiasAntesFacturaHoy;
                var diasFaltanFactura = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
                if (diasFaltanFactura <= -1 * diasAntesFactura)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Lo sentimos no puede desuscribirse, porque " + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ") + " es cierre de campaña."
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
                    userData.Menu = null;
                }

                SetUserData(userData);

                return Json(new
                {
                    success = userData.RevistaDigital.EstadoSuscripcion > 0,
                    message = userData.RevistaDigital.EstadoSuscripcion > 0 ? "" : "Ocurrió un error, vuelva a intentarlo."
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