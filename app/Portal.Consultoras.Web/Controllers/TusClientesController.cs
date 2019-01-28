using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class TusClientesController : BaseController
    {
        // GET: TusClientes
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Detalle()
        {
            return View(new ClienteModel { });
        }

        public JsonResult Consultar(string texto)
        {
            try
            {
                List<BECliente> lst = new List<BECliente>();
                if (ModelState.IsValid)
                {
                    using (ClienteServiceClient sv = new ClienteServiceClient())
                    {
                        lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                    }
                }
                if (texto.Trim().Length > 0)
                    lst = lst.FindAll(x => x.NombreCliente.Trim().ToUpper().Contains(texto.Trim().ToUpper()));

                return Json(new { miData = lst }, JsonRequestBehavior.AllowGet);
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
        public JsonResult Mantener(ClienteModel model)
        {
            string mensajePaso = string.Empty;

            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();

            try
            {
                mensajePaso = "|inicio";
                if (!string.IsNullOrEmpty(model.Celular))
                {
                    mensajePaso += "|validacion celular";
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
                    mensajePaso += "|validacion telefono";
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.TelefonoFijo,
                        Valor = model.Telefono
                    });
                }

                if (!string.IsNullOrEmpty(model.eMail))
                {
                    mensajePaso += "|validacion email";
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                        Valor = model.eMail
                    });
                }

                mensajePaso += "|clientes.Add(new BEClienteDB()";
                clientes.Add(new BEClienteDB()
                {
                    CodigoCliente = model.CodigoCliente,
                    ClienteID = model.ClienteID,
                    Nombres = model.NombreCliente,
                    Apellidos = model.ApellidoCliente,
                    ConsultoraID = userData.ConsultoraID,
                    Origen = Constantes.ClienteOrigen.Desktop,
                    Estado = Constantes.ClienteEstado.Activo,
                    Contactos = contactos.ToArray()
                });

                List<BEClienteDB> response;
                using (var sv = new ClienteServiceClient())
                {
                    mensajePaso += "|dentro de using (var sv = new ClienteServiceClient())";
                    response = sv.SaveDB(userData.PaisID, clientes.ToArray()).ToList();
                    mensajePaso += "|SaveDB = " + response.Count;
                }

                var itemResponse = response.First();
                mensajePaso += "| CodigoRespuesta = " + itemResponse.CodigoRespuesta;

                if (itemResponse.CodigoRespuesta == Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    return Json(new
                    {
                        success = true,
                        message = (itemResponse.Insertado ? "Se registró con éxito tu cliente." : "Se actualizó con éxito tu cliente."),
                        extra = string.Format("{0}|{1}", itemResponse.CodigoCliente, itemResponse.ClienteID),
                        mensajePaso
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = itemResponse.MensajeRespuesta,
                        mensajePaso
                    });
                }
            }
            catch (FaultException ex)
            {
                mensajePaso += "|catch FaultException";
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    mensajePaso,
                    Trycatch = Common.LogManager.GetMensajeError(ex)
                });
            }
            catch (Exception ex)
            {
                mensajePaso += "|catch exception";
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    mensajePaso,
                    Trycatch = Common.LogManager.GetMensajeError(ex)
                });
            }
        }
    }
}