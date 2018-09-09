using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarFactoresGananciaController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ConfiguracionValidacion/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var administrarFactoresGananciaModel = new AdministrarFactoresGananciaModel()
                {
                    listaPaises = DropDowListPaises()
                };
                return View(administrarFactoresGananciaModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new CronogramaModel());
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

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            if (ModelState.IsValid)
            {
                List<BEFactorGanancia> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectFactorGanancia(userData.PaisID).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEFactorGanancia> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderBy(x => x.PaisNombre);
                            break;
                        case "RangoMinimo":
                            items = lst.OrderBy(x => x.RangoMinimo);
                            break;
                        case "RangoMaximo":
                            items = lst.OrderBy(x => x.RangoMaximo);
                            break;
                        case "Porcentaje":
                            items = lst.OrderBy(x => x.Porcentaje);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderByDescending(x => x.PaisNombre);
                            break;
                        case "RangoMinimo":
                            items = lst.OrderByDescending(x => x.RangoMinimo);
                            break;
                        case "RangoMaximo":
                            items = lst.OrderByDescending(x => x.RangoMaximo);
                            break;
                        case "Porcentaje":
                            items = lst.OrderByDescending(x => x.Porcentaje);
                            break;
                    }
                }
                #endregion

                if (string.IsNullOrEmpty(vBusqueda))
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                else
                    items = items.Where(p => p.PaisID.ToString().ToUpper().Contains(vBusqueda.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Paginador(grid, vBusqueda);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.FactorGananciaID.ToString(),
                               cell = new string[]
                               {
                                   a.FactorGananciaID.ToString(),
                                   a.PaisID.ToString(),
                                   a.PaisNombre,
                                   Convert.ToString(a.RangoMinimo),
                                   Convert.ToString(a.RangoMaximo),
                                   Convert.ToString(a.Porcentaje)
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarFactoresGanancia");
        }

        public BEPager Paginador(BEGrid item, string vBusqueda)
        {
            List<BEFactorGanancia> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.SelectFactorGanancia(userData.PaisID).ToList();
            }

            BEPager pag = new BEPager();

            int recordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                recordCount = lst.Count;
            else
                recordCount = lst.Count(p => p.PaisNombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        [HttpPost]
        public JsonResult Mantener(AdministrarFactoresGananciaModel model)
        {
            if (model.FactorGananciaID == 0)
                return Insertar(model);
            else
                return Actualizar(model);
        }

        [HttpPost]
        public JsonResult Insertar(AdministrarFactoresGananciaModel model)
        {
            try
            {
                BEFactorGanancia entidad = Mapper.Map<AdministrarFactoresGananciaModel, BEFactorGanancia>(model);
                int rangoValido;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    rangoValido = sv.InsertFactorGanancia(entidad);
                }

                if (rangoValido == 0)
                    return Json(new
                    {
                        success = true,
                        message = "Se registró con éxito tu factor de ganancia.",
                        extra = ""
                    });
                else
                    return Json(new
                    {
                        success = false,
                        message = "La información del rango ingresado coincide con uno de los rangos de la lista. Por favor corregir.",
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
        public JsonResult Actualizar(AdministrarFactoresGananciaModel model)
        {
            try
            {
                BEFactorGanancia entidad = Mapper.Map<AdministrarFactoresGananciaModel, BEFactorGanancia>(model);
                int rangoValido;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    rangoValido = sv.UpdateFactorGanancia(entidad);
                }
                if (rangoValido == 0)
                    return Json(new
                    {
                        success = true,
                        message = "Se actualizó con éxito tu factor de ganancia.",
                        extra = ""
                    });
                else
                    return Json(new
                    {
                        success = false,
                        message = "La información del rango ingresado coincide con uno de los rangos de la lista. Por favor corregir.",
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

        public JsonResult Eliminar(int FactorGananciaID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteFactorGanancia(userData.PaisID, FactorGananciaID);
                }
                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
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
    }
}
