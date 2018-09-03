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
            if (model.ClienteID != 0)
            {
                try
                {
                    ModelState.Clear();
                    using (var sv = new ClienteServiceClient())
                    {
                        var clienteService = sv.SelectByConsultoraByCodigo(userData.PaisID, userData.ConsultoraID, model.ClienteID, 0);
                        model = Mapper.Map<ClienteMobileModel>(clienteService);
                    }
                }
                catch (FaultException ex) { LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO); }
                catch (Exception ex) { LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO); }
            }
            return PartialView(model);
        }

        [HttpPost]
        public JsonResult Guardar(ClienteMobileModel model)
        {
            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();

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

                List<BEClienteDB> response;
                using (var sv = new ClienteServiceClient())
                {
                    response = sv.SaveDB(userData.PaisID, clientes.ToArray()).ToList();
                }

                var itemResponse = response.FirstOrDefault() ?? new BEClienteDB();

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

        [HttpPost]
        public JsonResult Eliminar(int clienteId)
        {
            
            try
            {
                bool rslt;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    rslt = sv.Delete(userData.PaisID, userData.ConsultoraID, clienteId);
                }

                var mensaje = rslt
                    ? "Se eliminó satisfactoriamente el registro."
                    : "No es posible eliminar al cliente dado que se encuentra asociado a un pedido.";

                return Json(new
                {
                    success = rslt,
                    message = mensaje,
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
