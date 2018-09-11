using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ParametrizarCUVController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ParametrizarCUV/Index"))
                return RedirectToAction("Index", "Bienvenida");

            var parametrizarCuvModel = new ParametrizarCUVModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaZonas = new List<ZonaModel>(),
                listaPaises = DropDowListPaises()
            };

            return View(parametrizarCuvModel);
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

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string CampaniaID, string PaisID, string Consulta)
        {
            if (ModelState.IsValid)
            {
                List<BEMensajeCUV> lst;

                if (Consulta == "1")
                {
                    using (ODSServiceClient sv = new ODSServiceClient())
                    {
                        lst = sv.GetMensajesCUVsByPaisAndCampania(CampaniaID == "" ? 0 : int.Parse(CampaniaID), PaisID == string.Empty ? 5 : int.Parse(PaisID)).ToList();
                    }
                }
                else
                {
                    lst = new List<BEMensajeCUV>();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEMensajeCUV> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Mensaje":
                            items = lst.OrderBy(x => x.Mensaje);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.Cuvs);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Mensaje":
                            items = lst.OrderByDescending(x => x.Mensaje);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.Cuvs);
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
                               a.ParametroID,
                               cell = new string[]
                               {
                                   a.ParametroID.ToString(),
                                   a.PaisID.ToString(),
                                   a.CampaniaID.ToString(),
                                   a.Mensaje,
                                   a.Cuvs
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "ParametrizarCUV");
        }

        [HttpPost]
        public JsonResult Registrar(string ParametroID, string PaisID, string CampaniaID, string Mensaje, string CUVs)
        {
            try
            {
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    sv.SetMensajesCUVsByPaisAndCampania(Convert.ToInt32(ParametroID), Convert.ToInt32(PaisID),
                        Convert.ToInt32(CampaniaID), Mensaje, CUVs);
                }

                string operacion = ParametroID != "0" ? "actualizó" : "registró";

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito el mensaje.", operacion),
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
        public JsonResult Eliminar(string PaisID, string ParametroID)
        {
            try
            {


                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    sv.DeleteMensajesCUVsByPaisAndCampania(Convert.ToInt32(ParametroID), (PaisID.Trim() == string.Empty) ? userData.PaisID : Convert.ToInt32(PaisID));
                }
                return Json(new
                {
                    success = true,
                    message = "Se eliminó con éxito el mensaje.",
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
