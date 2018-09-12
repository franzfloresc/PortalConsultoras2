using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministracionOfertaController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministracionOferta/Index"))
                return RedirectToAction("Index", "Bienvenida");

            var cronogramaModel = new OfertaProductoModel()
            {
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
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

        [HttpPost]
        public JsonResult Mantener(ConfiguracionOfertaModel model)
        {
            if (model.ConfiguracionOfertaID == 0)
                return Insert(model);
            else
                return Update(model);
        }

        [HttpPost]
        public JsonResult Update(ConfiguracionOfertaModel model)
        {
            try
            {
                BEConfiguracionOferta entidad = Mapper.Map<ConfiguracionOfertaModel, BEConfiguracionOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    sv.UpdConfiguracionOferta(entidad);
                }


                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito el Código de Oferta.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult Insert(ConfiguracionOfertaModel model)
        {
            try
            {
                BEConfiguracionOferta entidad = Mapper.Map<ConfiguracionOfertaModel, BEConfiguracionOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    sv.InsConfiguracionOferta(entidad);
                }


                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito el Código de Oferta.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int PaisID, int TipoOfertaSisID)
        {
            if (ModelState.IsValid)
            {
                List<BEConfiguracionOferta> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetConfiguracionOfertaAdministracion(PaisID, TipoOfertaSisID).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEConfiguracionOferta> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Administrador":
                            items = lst.OrderBy(x => x.TipoOfertaSisID);
                            break;
                        case "CodigoOferta":
                            items = lst.OrderBy(x => x.CodigoOferta);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "Estado":
                            items = lst.OrderBy(x => x.EstadoRegistro);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Administrador":
                            items = lst.OrderByDescending(x => x.TipoOfertaSisID);
                            break;
                        case "CodigoOferta":
                            items = lst.OrderByDescending(x => x.CodigoOferta);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "Estado":
                            items = lst.OrderByDescending(x => x.EstadoRegistro);
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
                               id = a.ConfiguracionOfertaID,
                               cell = new string[]
                               {
                                   a.TipoOfertaSisID.ToString(),
                                   a.CodigoOferta,
                                   a.Descripcion,
                                   a.EstadoRegistro.ToString(),
                                   a.ConfiguracionOfertaID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult Eliminar(int PaisID, int ConfiguracionOfertaID)
        {
            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.DelConfiguracionOferta(PaisID, ConfiguracionOfertaID);
                }
                return Json(new
                {
                    success = true,
                    message = "Se eliminó con éxito el Código de Oferta.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public JsonResult ValidarCodigoOferta(int paisID, string codigoOferta)
        {
            int rslt;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                rslt = sv.ValidarCodigoOfertaAdministracion(paisID, codigoOferta);
            }

            return Json(new
            {
                existe = rslt
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
