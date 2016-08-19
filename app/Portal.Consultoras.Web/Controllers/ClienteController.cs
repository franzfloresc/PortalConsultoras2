using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class ClienteController : BaseController
    {
        #region Actions

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Cliente/Index"))
                return RedirectToAction("Index", "Bienvenida");

            return View();
        }

        public ActionResult MisClientes()
        {

            return View();

        }

        [HttpPost]
        public JsonResult Mantener(ClienteModel model)
        {
            if (model.ClienteID == 0)
                return Insert(model);
            else
                return Update(model);
        }

        [HttpPost]
        public JsonResult Update(ClienteModel model)
        {
            int vValidation = 0;
            try
            {
                Mapper.CreateMap<ClienteModel, BECliente>()
                    .ForMember(t => t.ClienteID, f => f.MapFrom(c => c.ClienteID))
                    .ForMember(t => t.eMail, f => f.MapFrom(c => c.eMail))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

                BECliente entidad = Mapper.Map<ClienteModel, BECliente>(model);
                //string x = "sdasda";
                //int dsds = int.Parse(x);
                entidad.ClienteID = model.ClienteID;

                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    if (model.FlagValidate == 1)
                    {
                        vValidation = sv.CheckClienteByConsultora(UserData().PaisID, UserData().ConsultoraID, model.Nombre);
                        if (vValidation > 0)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "El nombre del cliente ya se encuentra registrado, verifique.",
                                extra = ""
                            });
                        }
                    }

                    entidad.PaisID = UserData().PaisID;
                    entidad.ConsultoraID = UserData().ConsultoraID;
                    entidad.Activo = true;
                    sv.Update(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu cliente.",
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
        public JsonResult Insert(ClienteModel model)
        {
            int vValidation = 0;
            try
            {
                Mapper.CreateMap<ClienteModel, BECliente>()
                    .ForMember(t => t.eMail, f => f.MapFrom(c => c.eMail))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

                BECliente entidad = Mapper.Map<ClienteModel, BECliente>(model);

                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    vValidation = sv.CheckClienteByConsultora(UserData().PaisID, UserData().ConsultoraID, model.Nombre);

                    if (vValidation == 0)
                    {
                        entidad.PaisID = UserData().PaisID;
                        entidad.ConsultoraID = UserData().ConsultoraID;
                        entidad.Activo = true;
                        sv.Insert(entidad);
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "El nombre del cliente ya se encuentra registrado, verifique.",
                            extra = ""
                        });
                    }
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito tu cliente.",
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

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            if (ModelState.IsValid)
            {
                List<BECliente> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.SelectByConsultora(UserData().PaisID, UserData().ConsultoraID).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BECliente> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderBy(x => x.Nombre);
                            break;
                        case "eMail":
                            items = lst.OrderBy(x => x.eMail);
                            break;
                        case "ClienteID":
                            items = lst.OrderBy(x => x.ClienteID);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderByDescending(x => x.Nombre);
                            break;
                        case "eMail":
                            items = lst.OrderByDescending(x => x.eMail);
                            break;
                        case "ClienteID":
                            items = lst.OrderByDescending(x => x.ClienteID);
                            break;
                    }
                }
                #endregion

                if (string.IsNullOrEmpty(vBusqueda))
                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                else
                    items = items.Where(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

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
                               id = a.ClienteID,
                               cell = new string[] 
                               {
                                   a.ClienteID.ToString(),
                                   a.Nombre,
                                   a.eMail,
                                   Convert.ToString(Convert.ToInt32(a.Activo)),
                                   a.ConsultoraID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index","Bienvenida");
        }

        public JsonResult Eliminar(int ClienteID)
        {
            try
            {
                bool rslt = false;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    rslt = sv.Delete(UserData().PaisID, UserData().ConsultoraID, ClienteID);
                }
                string Mensaje = string.Empty;
                if (rslt)
                    Mensaje = "Se eliminó satisfactoriamente el registro.";
                else
                    Mensaje = "No es posible eliminar al cliente dado que se encuentra asociado a un pedido.";

                return Json(new
                {
                    success = true,
                    message = Mensaje,
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

        public JsonResult DeshacerCambios(int ClienteID)
        {
            try
            {
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    sv.UndoCliente(UserData().PaisID, UserData().ConsultoraID, ClienteID);
                }
                return Json(new
                {
                    success = true,
                    message = "Se deshicieron los cambios satisfactoriamente",
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

        #endregion

        #region Método Paginador

        public BEPager Paginador(BEGrid item, string vBusqueda)
        {
            List<BECliente> lst;
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lst = sv.SelectByConsultora(UserData().PaisID, UserData().ConsultoraID).ToList();
            }

            BEPager pag = new BEPager();

            int RecordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Where(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Count();

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

        #endregion
    }
}
