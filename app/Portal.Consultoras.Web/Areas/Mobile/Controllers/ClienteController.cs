using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

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

            var listaClienteModel = Mapper.Map<List<BECliente>, List<ClienteMobileModel>>(listaClientes);

            return View(listaClienteModel);
        }

        [HttpGet]
        public PartialViewResult AgregarCliente(ClienteMobileModel model)
        {
            ModelState.Clear();

            using (var sv = new ClienteServiceClient())
            {
                var clienteService = sv.SelectByConsultoraByCodigo(userData.PaisID, userData.ConsultoraID, model.ClienteID, 0);

                model = new ClienteMobileModel()
                {
                    ClienteID = clienteService.ClienteID,
                    CodigoCliente = clienteService.CodigoCliente,
                    Nombre = clienteService.Nombre,
                    NombreCliente = clienteService.NombreCliente,
                    ApellidoCliente = clienteService.ApellidoCliente,
                    Celular = clienteService.Celular,
                    Telefono = clienteService.Telefono,
                    Email = clienteService.eMail,
                };
            }

            return PartialView(model);
        }

        [HttpPost]
        public JsonResult Guardar(ClienteMobileModel model)
        {
            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();
            List<BEClienteDB> response = new List<BEClienteDB>();

            try
            {
                if (!string.IsNullOrEmpty(model.Celular))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.Celular,
                        Valor = model.Celular
                    });
                }

                if (!string.IsNullOrEmpty(model.Telefono))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.TelefonoFijo,
                        Valor = model.Telefono
                    });
                }

                if (!string.IsNullOrEmpty(model.Email))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                        Valor = model.Email
                    });
                }

                clientes.Add(new BEClienteDB()
                {
                    CodigoCliente = model.CodigoCliente,
                    ClienteID = model.ClienteID,
                    Nombres = model.NombreCliente,
                    Apellidos = model.ApellidoCliente,
                    ConsultoraID = userData.ConsultoraID,
                    Origen = Constantes.ClienteOrigen.Mobile,
                    Estado = Constantes.ClienteEstado.Activo,
                    Contactos = contactos.ToArray()
                });

                using (var sv = new ClienteServiceClient())
                {
                    response = sv.SaveDB(userData.PaisID, clientes.ToArray()).ToList();
                }

                var itemResponse = response.First();

                if (itemResponse.CodigoRespuesta == Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    return Json(new
                    {
                        success = true,
                        message = (itemResponse.Insertado ? "Cliente registrado satisfactoriamente." : "Se actualizó con éxito tu cliente."),
                        extra = string.Format("{0}|{1}", itemResponse.CodigoCliente, itemResponse.ClienteID),
                        insertado = itemResponse.Insertado
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = itemResponse.MensajeRespuesta,
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

        //[HttpPost]
        //public JsonResult Insertar(ClienteMobileModel model)
        //{
        //    var userData = UserData();
        //    try
        //    {
        //        Mapper.CreateMap<ClienteMobileModel, BECliente>()
        //            .ForMember(t => t.eMail, f => f.MapFrom(c => c.Email))
        //            .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
        //            .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono));

        //        var entidad = Mapper.Map<ClienteMobileModel, BECliente>(model);

        //        using (var sv = new ClienteServiceClient())
        //        {
        //            var vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);

        //            if (vValidation == 0)
        //            {
        //                entidad.PaisID = userData.PaisID;
        //                entidad.ConsultoraID = userData.ConsultoraID;
        //                entidad.Activo = true;
        //                entidad.eMail = model.Email;
        //                entidad.Telefono = model.Telefono;
        //                entidad.Nombre = model.Nombre;

        //                entidad.ClienteID = sv.InsertById(entidad);

        //                return Json(new
        //                {
        //                    success = true,
        //                    message = "Cliente registrado satisfactoriamente.",
        //                    extra = entidad
        //                });
        //            }
        //            else
        //            {
        //                return Json(new
        //                {
        //                    success = false,
        //                    message = "El nombre del cliente ya se encuentra registrado, por favor verifique.",
        //                    extra = ""
        //                });
        //            }
        //        }
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
        //            extra = ""
        //        });
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
        //            extra = ""
        //        });
        //    }
        //}

        //[HttpPost]
        //public JsonResult Actualizar(ClienteMobileModel model)
        //{
        //    var userData = UserData();
        //    try
        //    {
        //        Mapper.CreateMap<ClienteMobileModel, BECliente>()
        //            .ForMember(t => t.ClienteID, f => f.MapFrom(c => c.ClienteID))
        //            .ForMember(t => t.eMail, f => f.MapFrom(c => c.Email))
        //            .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

        //        BECliente entidad = Mapper.Map<ClienteMobileModel, BECliente>(model);
        //        //string x = "sdasda";
        //        //int dsds = int.Parse(x);
        //        entidad.ClienteID = model.ClienteID;

        //        using (ClienteServiceClient sv = new ClienteServiceClient())
        //        {
        //            if (model.FlagValidate == 1)
        //            {
        //                var vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);
        //                if (vValidation > 0)
        //                {
        //                    return Json(new
        //                    {
        //                        success = false,
        //                        message = "El nombre del cliente ya se encuentra registrado, verifique.",
        //                        extra = ""
        //                    });
        //                }
        //            }


        //            entidad.PaisID = userData.PaisID;
        //            entidad.ConsultoraID = userData.ConsultoraID;
        //            entidad.Activo = true;
        //            sv.Update(entidad);
        //        }
        //        return Json(new
        //        {
        //            success = true,
        //            message = "Se actualizó con éxito tu cliente.",
        //            extra = entidad
        //        });
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //}

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
