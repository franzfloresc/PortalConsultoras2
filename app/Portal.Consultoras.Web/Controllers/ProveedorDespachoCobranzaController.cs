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

            var proveedorDespachoCobranzaModel = new ProveedorDespachoCobranzaModel()
            {
                lstPais = DropDowListPaises(),
                lstProveedores = DropDowListProveedores(userData.PaisID)
            };

            return View(proveedorDespachoCobranzaModel);
        }

        private IEnumerable<ProveedorDespachoCobranzaModel> DropDowListProveedores(int paisId)
        {
            IList<BEProveedorDespachoCobranza> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetProveedorDespachoCobranza(paisId);
            }

            return Mapper.Map<IList<BEProveedorDespachoCobranza>, IEnumerable<ProveedorDespachoCobranzaModel>>(lst);
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

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vDescripcion)
        {
            if (ModelState.IsValid)
            {
                int paisId = userData.PaisID;
                if (paisId.ToString() != "")
                {
                    List<BEProveedorDespachoCobranza> lst;
                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        lst = srv.GetProveedorDespachoCobranza(paisId).ToList();
                    }

                    BEGrid grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };

                    IEnumerable<BEProveedorDespachoCobranza> items = lst;

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
                                       a.NombreComercial,
                                       a.RazonSocial,
                                       a.RFC
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
            string returnValue = "";
            try
            {
                int paisId = userData.PaisID;

                BEProveedorDespachoCobranza proveedorDespachoCobranza = Mapper.Map<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>(model);

                List<BEProveedorDespachoCobranza> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    proveedorDespachoCobranza.PaisID = userData.PaisID;
                    lst = sv.GetProveedorDespachoCobranzaBYiD(paisId, proveedorDespachoCobranza).ToList();
                }

                if (lst.Count > 0)
                {
                    var valor = lst[0].Valor;
                    if (proveedorDespachoCobranza.CampoId == 3 || proveedorDespachoCobranza.CampoId == 4)
                    {
                        if (valor != "")
                        {
                            returnValue = "No se puede ingresar mas datos.";
                        }
                    }
                    else
                    {
                        var arrString = valor.Split(',');

                        if (
                            (valor == "1" || valor == "2" || valor == "6")
                            && arrString.Count() > 6)
                        {
                            returnValue = "No se puede ingresar mas datos.";
                        }

                        if (valor == "7" && arrString.Count() > 2)
                        {
                            returnValue = "No se puede ingresar mas datos.";
                        }

                        if (valor == "8" && arrString.Count() > 49)
                        {
                            returnValue = "No se puede ingresar mas datos.";
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo ingresar Campo",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

                using (SACServiceClient sv = new SACServiceClient())
                {
                    proveedorDespachoCobranza.PaisID = userData.PaisID;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo actualizar el Campo, intente nuevamente",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                BEProveedorDespachoCobranza proveedorDespachoCobranza = Mapper.Map<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    proveedorDespachoCobranza.PaisID = userData.PaisID;
                    sv.InsProveedorDespachoCobranzaCabecera(userData.PaisID, proveedorDespachoCobranza);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                int paisId = userData.PaisID;

                BEProveedorDespachoCobranza proveedorDespachoCobranza = Mapper.Map<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    proveedorDespachoCobranza.PaisID = userData.PaisID;
                    sv.UpdProveedorDespachoCobranzaCabecera(paisId, proveedorDespachoCobranza);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo actualizar el Proveedor, intente nuevamente",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                int paisId = userData.PaisID;
                int result;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    result = sv.DelProveedorDespachoCobranza(paisId, ProveedorDespachoCobranzaID);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                int paisId = userData.PaisID;

                BEProveedorDespachoCobranza entidad = new BEProveedorDespachoCobranza
                {
                    ProveedorDespachoCobranzaID = ProveedorDespachoCobranzaId,
                    CampoId = CampoID
                };

                List<BEProveedorDespachoCobranza> lst;
                using (SACServiceClient srv = new SACServiceClient())
                {
                    lst = srv.GetProveedorDespachoCobranzaMnto(paisId, entidad).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEProveedorDespachoCobranza> items = lst;

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
                                   a.NombreComercial,
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

