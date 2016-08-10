using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServiceCliente;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ClienteController : BaseMobileController
    {
        public ActionResult Index()
        {
            var userData = UserData();
            List<BECliente> listaClientes;

            using (var sv = new ClienteServiceClient())
            {
                listaClientes = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }

            Mapper.CreateMap<BECliente, ClienteMobileModel>()
                .ForMember(t => t.Email, f => f.MapFrom(c => c.eMail))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono));

            var listaClienteModel = Mapper.Map<List<BECliente>, List<ClienteMobileModel>>(listaClientes);

            return View(listaClienteModel);
        }

        [HttpPost]
        public JsonResult Guardar(ClienteMobileModel model)
        {
            return model.ClienteID == 0 ? Insertar(model) : Actualizar(model);
        }

        [HttpPost]
        public JsonResult Insertar(ClienteMobileModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<ClienteMobileModel, BECliente>()
                    .ForMember(t => t.eMail, f => f.MapFrom(c => c.Email))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono));

                var entidad = Mapper.Map<ClienteMobileModel, BECliente>(model);

                using (var sv = new ClienteServiceClient())
                {
                    var vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);

                    if (vValidation == 0)
                    {
                        entidad.PaisID = userData.PaisID;
                        entidad.ConsultoraID = userData.ConsultoraID;
                        entidad.Activo = true;
                        entidad.eMail = model.Email;
                        entidad.Telefono = model.Telefono;
                        entidad.Nombre = model.Nombre;

                        entidad.ClienteID = sv.InsertById(entidad);

                        return Json(new
                        {
                            success = true,
                            message = "Cliente registrado satisfactoriamente.",
                            extra = entidad
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "El nombre del cliente ya se encuentra registrado, por favor verifique.",
                            extra = ""
                        });
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult Actualizar(ClienteMobileModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<ClienteMobileModel, BECliente>()
                    .ForMember(t => t.ClienteID, f => f.MapFrom(c => c.ClienteID))
                    .ForMember(t => t.eMail, f => f.MapFrom(c => c.Email))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

                BECliente entidad = Mapper.Map<ClienteMobileModel, BECliente>(model);
                //string x = "sdasda";
                //int dsds = int.Parse(x);
                entidad.ClienteID = model.ClienteID;

                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    if (model.FlagValidate == 1)
                    {
                        var vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);
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


                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.Activo = true;
                    sv.Update(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu cliente.",
                    extra = entidad
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
        public JsonResult Eliminar(int clienteId)
        {
            var userData = UserData();
            try
            {
                bool rslt = false;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    rslt = sv.Delete(userData.PaisID, userData.ConsultoraID, clienteId);
                }
                string Mensaje = string.Empty;
                Mensaje = rslt
                    ? "Se eliminó satisfactoriamente el registro."
                    : "No es posible eliminar al cliente dado que se encuentra asociado a un pedido.";

                return Json(new
                {
                    success = rslt,
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
    }
}
