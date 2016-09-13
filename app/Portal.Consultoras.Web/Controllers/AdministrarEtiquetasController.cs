using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceSAC;
using System.IO;
using System.Drawing;
using System.ServiceModel;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEtiquetasController : BaseController
    {
        //
        // GET: /AdministrarEtiquetas/

        public ActionResult Index(EtiquetaModel model)
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarEtiquetas/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                model.listaPaises = DropDowListPaises();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
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

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string PaisID, string Consulta)
        {
            if (ModelState.IsValid)
            {
                List<BEEtiqueta> lst;
                BEEtiqueta entidad = new BEEtiqueta();
                entidad.PaisID = UserData().PaisID;
                entidad.Estado = -1;

                if (Consulta == "1")
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        lst = sv.GetEtiquetas(entidad).ToList();
                    }
                }
                else
                {
                    lst = new List<BEEtiqueta>();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEEtiqueta> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "EtiquetaID":
                            items = lst.OrderBy(x => x.EtiquetaID);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "EtiquetaID":
                            items = lst.OrderByDescending(x => x.EtiquetaID);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               a.EtiquetaID,
                               cell = new string[] 
                               {
                                   a.EtiquetaID.ToString(),
                                   a.Descripcion.ToString(),
                                   a.Estado.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEtiquetas");
        }
        
        [HttpPost]
        public JsonResult Eliminar(string PaisID, string EtiquetaID)
        {
            int resultado = 0;
            string operacion = "eliminó";
            try
            {
                BEEtiqueta entidad = new BEEtiqueta();
                entidad.EtiquetaID = Convert.ToInt32(EtiquetaID);
                entidad.PaisID = Convert.ToInt32(PaisID);
                entidad.Estado = 0;
                
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.InsertarEtiqueta(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito el mensaje.", operacion),
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
        public JsonResult Registrar(string PaisID, string Descripcion, string EtiquetaID)
        {
            int resultado = 0;
            string operacion = "registró";
            try
            {
                BEEtiqueta entidad = new BEEtiqueta();
                entidad.EtiquetaID = Convert.ToInt32(EtiquetaID);
                entidad.PaisID = Convert.ToInt32(PaisID);
                entidad.Descripcion = Descripcion;
                entidad.Estado = 1;
                entidad.UsuarioCreacion = UserData().CodigoUsuario;
                entidad.UsuarioModificacion = UserData().CodigoUsuario;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.InsertarEtiqueta(entidad);
                }

                if (EtiquetaID != "0")
                {
                    operacion = "actualizó";
                }

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito el mensaje.", operacion),
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
