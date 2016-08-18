using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new CronogramaModel());
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            if (ModelState.IsValid)
            {
                List<BEFactorGanancia> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectFactorGanancia(UserData().PaisID).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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
                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                else
                    items = items.Where(p => p.PaisID.ToString().ToUpper().Contains(vBusqueda.ToUpper())).ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, vBusqueda);

                // Creamos la estructura
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
                lst = sv.SelectFactorGanancia(UserData().PaisID).ToList();
            }

            BEPager pag = new BEPager();

            int RecordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Where(p => p.PaisNombre.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Count();

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

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
            //int vValidation = 0;
            try
            {
                Mapper.CreateMap<AdministrarFactoresGananciaModel, BEFactorGanancia>()
                   .ForMember(t => t.FactorGananciaID, f => f.MapFrom(c => c.FactorGananciaID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.RangoMinimo, f => f.MapFrom(c => c.RangoMinimo))
                   .ForMember(t => t.RangoMaximo, f => f.MapFrom(c => c.RangoMaximo))
                   .ForMember(t => t.Porcentaje, f => f.MapFrom(c => c.Porcentaje));

                BEFactorGanancia entidad = Mapper.Map<AdministrarFactoresGananciaModel, BEFactorGanancia>(model);
                int RangoValido = 0;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    RangoValido = sv.InsertFactorGanancia(entidad);
                }

                if (RangoValido == 0)
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

        [HttpPost]
        public JsonResult Actualizar(AdministrarFactoresGananciaModel model)
        {
            try
            {
                Mapper.CreateMap<AdministrarFactoresGananciaModel, BEFactorGanancia>()
                    .ForMember(t => t.FactorGananciaID, f=> f.MapFrom(c => c.FactorGananciaID))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.RangoMinimo, f => f.MapFrom(c => c.RangoMinimo))
                    .ForMember(t => t.RangoMaximo, f => f.MapFrom(c => c.RangoMaximo))
                    .ForMember(t => t.Porcentaje, f => f.MapFrom(c => c.Porcentaje));

                BEFactorGanancia entidad = Mapper.Map<AdministrarFactoresGananciaModel, BEFactorGanancia>(model);
                int RangoValido = 0;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    RangoValido = sv.UpdateFactorGanancia(entidad);
                }
                if (RangoValido == 0)
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

        public JsonResult Eliminar(int FactorGananciaID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteFactorGanancia(UserData().PaisID, FactorGananciaID);
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
