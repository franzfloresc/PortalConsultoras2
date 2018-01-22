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
    public class ProveedorDespachoCobranzaController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ProveedorDespachoCobranza/Index"))
                return RedirectToAction("Index", "Bienvenida");

            var ProveedorDespachoCobranzaModel = new ProveedorDespachoCobranzaModel()
            {
                lstPais = DropDowListPaises(),
                lstProveedores = DropDowListProveedores(UserData().PaisID)
            };

            return View(ProveedorDespachoCobranzaModel);
        }

        private IEnumerable<ProveedorDespachoCobranzaModel> DropDowListProveedores(int PaisID)
        {
            IList<BEProveedorDespachoCobranza> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetProveedorDespachoCobranza(PaisID);
            }

            return Mapper.Map<IList<BEProveedorDespachoCobranza>, IEnumerable<ProveedorDespachoCobranzaModel>>(lst);
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

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vDescripcion)
        {
            if (ModelState.IsValid)
            {
                int paisID = UserData().PaisID;
                if (paisID.ToString() != "")
                {
                    List<ServiceSAC.BEProveedorDespachoCobranza> lst;
                    using (ServiceSAC.SACServiceClient srv = new ServiceSAC.SACServiceClient())
                    {
                        lst = srv.GetProveedorDespachoCobranza(paisID).ToList();
                    }

                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;

                    IEnumerable<ServiceSAC.BEProveedorDespachoCobranza> items = lst;

                    #region Sort Section
                    if (sord == "asc")
                    {
                        switch (sidx)
                        {
                            case "Descripcion":
                                items = lst.OrderBy(x => x.NombreComercial);
                                break;
                        }
                    }
                    else
                    {
                        switch (sidx)
                        {
                            case "Descripcion":
                                items = lst.OrderByDescending(x => x.NombreComercial);
                                break;
                        }
                    }
                    #endregion

                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                    BEPager pag = Util.PaginadorGenerico(grid, lst.ToList());

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.ProveedorDespachoCobranzaID,
                                   cell = new string[]
                                    {
                                       a.ProveedorDespachoCobranzaID.ToString(),
                                       a.NombreComercial.ToString(),
                                       a.RazonSocial.ToString(),
                                       a.RFC.ToString()
                                    }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }

            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult MantenerCampo(ProveedorDespachoCobranzaModel model)
        {
            return ActualizarCampo(model);
        }

        [HttpPost]
        public JsonResult ObtenerDatosCampo(ProveedorDespachoCobranzaModel model)
        {
            string Valor;
            string returnValue = "";
            try
            {
                int PaisID = UserData().PaisID;

                BEProveedorDespachoCobranza proveedorDespachoCobranza = Mapper.Map<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>(model);

                List<ServiceSAC.BEProveedorDespachoCobranza> lst;
                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    proveedorDespachoCobranza.PaisID = UserData().PaisID;
                    lst = sv.GetProveedorDespachoCobranzaBYiD(PaisID, proveedorDespachoCobranza).ToList();
                }

                if (lst.Count > 0)
                {
                    Valor = lst[0].Valor;
                    if (proveedorDespachoCobranza.CampoId == 3 || proveedorDespachoCobranza.CampoId == 4)
                    {
                        if (Valor != "")
                        {
                            returnValue = "No se puede ingresar mas datos.";
                        }
                    }
                    else
                    {
                        string[] arrString;
                        arrString = Valor.Split(',');

                        if (Valor == "1" || Valor == "2" || Valor == "6")
                        {
                            if (arrString.Count() > 6)
                            {
                                returnValue = "No se puede ingresar mas datos.";
                            }
                        }
                        if (Valor == "7")
                        {
                            if (arrString.Count() > 2)
                            {
                                returnValue = "No se puede ingresar mas datos.";
                            }
                        }

                        if (Valor == "8")
                        {
                            if (arrString.Count() > 49)
                            {
                                returnValue = "No se puede ingresar mas datos.";
                            }
                        }

                    }

                }

                return Json(new
                {
                    valor = returnValue,
                    success = true,
                    message = "El Campo ha sido actualizado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo ingresar Campo",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el Campo, intente nuevamente",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult ActualizarCampo(ProveedorDespachoCobranzaModel model)
        {
            try
            {
                BEProveedorDespachoCobranza proveedorDespachoCobranza = Mapper.Map<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>(model);

                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    proveedorDespachoCobranza.PaisID = UserData().PaisID;
                    sv.MntoCampoProveedorDespachoCobranza(proveedorDespachoCobranza, proveedorDespachoCobranza.Accion, proveedorDespachoCobranza.CampoId, proveedorDespachoCobranza.Valor, proveedorDespachoCobranza.ValorAnterior);
                }

                return Json(new
                {
                    success = true,
                    message = "El Campo ha sido actualizado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo actualizar el Campo, intente nuevamente",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el Campo, intente nuevamente",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult Mantener(ProveedorDespachoCobranzaModel model)
        {

            if (model.ProveedorDespachoCobranzaID == 0)
                return Insertar(model);
            else
                return Actualizar(model);
        }

        [HttpPost]
        public JsonResult Insertar(ProveedorDespachoCobranzaModel model)
        {
            try
            {
                BEProveedorDespachoCobranza ProveedorDespachoCobranza = Mapper.Map<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>(model);

                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    ProveedorDespachoCobranza.PaisID = UserData().PaisID;
                    sv.InsProveedorDespachoCobranzaCabecera(UserData().PaisID, ProveedorDespachoCobranza);
                }

                return Json(new
                {
                    success = true,
                    message = "Proveedor ha sido ingresado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult Actualizar(ProveedorDespachoCobranzaModel model)
        {
            try
            {
                int PaisID = UserData().PaisID;

                BEProveedorDespachoCobranza proveedorDespachoCobranza = Mapper.Map<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>(model);

                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    proveedorDespachoCobranza.PaisID = UserData().PaisID;
                    sv.UpdProveedorDespachoCobranzaCabecera(PaisID, proveedorDespachoCobranza);
                }

                return Json(new
                {
                    success = true,
                    message = "Proveedor ha sido actualizado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo actualizar el Proveedor, intente nuevamente",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el Proveedor, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult Eliminar(int ProveedorDespachoCobranzaID)
        {
            try
            {
                int PaisID = UserData().PaisID;
                int result = 0;

                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    result = sv.DelProveedorDespachoCobranza(PaisID, ProveedorDespachoCobranzaID);
                }
                if (result == 0)
                {
                    return Json(new
                    {
                        success = true,
                        message = "Se elimino satisfactoriamente el registro.",
                        extra = ""
                    });
                }
                else if (result == 1)
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se puede eliminar Rol del sistema.",
                        extra = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se puede eliminar Rol porque está asignado a uno o más usuarios.",
                        extra = ""
                    });
                }
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
        }

        public ActionResult ConsultarMnto(string sidx, string sord, int page, int rows, int ProveedorDespachoCobranzaId, int CampoID)
        {
            if (ModelState.IsValid)
            {
                int paisID = UserData().PaisID;

                BEProveedorDespachoCobranza entidad = new BEProveedorDespachoCobranza();
                entidad.ProveedorDespachoCobranzaID = ProveedorDespachoCobranzaId;
                entidad.CampoId = CampoID;

                List<ServiceSAC.BEProveedorDespachoCobranza> lst;
                using (ServiceSAC.SACServiceClient srv = new ServiceSAC.SACServiceClient())
                {
                    lst = srv.GetProveedorDespachoCobranzaMnto(paisID, entidad).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                
                IEnumerable<ServiceSAC.BEProveedorDespachoCobranza> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NombreComercial":
                            items = lst.OrderBy(x => x.NombreComercial);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NombreComercial":
                            items = lst.OrderByDescending(x => x.NombreComercial);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                BEPager pag = Util.PaginadorGenerico(grid, lst.ToList());

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ProveedorDespachoCobranzaID,
                               cell = new string[]
                               {
                                   a.ProveedorDespachoCobranzaID.ToString(),
                                   a.NombreComercial.ToString(),
                                   a.CampoId.ToString(),
                                   a.NombreCampo,
                                   a.Valor
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }
    }
}

