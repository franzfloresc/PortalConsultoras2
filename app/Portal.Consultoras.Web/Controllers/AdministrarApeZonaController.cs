using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarApeZonaController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarApeZona/Index"))
                return RedirectToAction("Index", "Bienvenida");

            var model = new AdministrarApeZonaModel();
            try
            {
                model.Regiones = _baseProvider.DropDownListRegiones(userData.PaisID);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return View(model);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vRegionID, string vCodigo)
        {
            if (ModelState.IsValid)
            {
                List<BEZona> lst = new List<BEZona>();

                try
                {
                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        lst = sv.SelectApeZonas(UserData().PaisID, vRegionID, vCodigo).ToList();
                    }
                }
                catch (FaultException ex)
                {
                    LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEZona> items = lst;

                #region Sort Section

                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Codigo":
                            items = lst.OrderBy(x => x.Codigo);
                            break;
                        case "Nombre":
                            items = lst.OrderBy(x => x.Nombre);
                            break;
                        case "CantidadDias":
                            items = lst.OrderBy(x => x.CantidadDias);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Codigo":
                            items = lst.OrderByDescending(x => x.Codigo);
                            break;
                        case "Nombre":
                            items = lst.OrderByDescending(x => x.Nombre);
                            break;
                        case "CantidadDias":
                            items = lst.OrderByDescending(x => x.CantidadDias);
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
                    ISOPais = UserData().CodigoISO,
                    rows = from a in items
                           select new
                           {
                               id = a.ZonaID.ToString(),
                               cell = new string[]
                               {
                                   a.ZonaID.ToString(),
                                   a.Codigo,
                                   a.Nombre,
                                   a.CantidadDias.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarApeZona");
        }

        [HttpPost]
        public JsonResult Actualizar(AdministrarApeZonaModel model)
        {
            try
            {
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    sv.UpdateApeZona(UserData().PaisID, model.ZonaID, model.CantidadDias);
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito la Zona.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
    }
}
