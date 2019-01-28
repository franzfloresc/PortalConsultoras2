using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.TusClientes;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.LogManager;

namespace Portal.Consultoras.Web.Controllers
{
    public class TusClientesController : BaseController
    {
        private readonly ClienteProvider _clienteProvider;

        public TusClientesController() : this(new ClienteProvider())
        {

        }

        public TusClientesController(ClienteProvider clienteProvider) : base()
        {
            _clienteProvider = clienteProvider;
        }

        public TusClientesController(ClienteProvider clienteProvider, ISessionManager sessionManager, ILogManager logManager)
            : base(sessionManager, logManager)
        {
            _clienteProvider = clienteProvider;
        }


        // GET: TusClientes
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Detalle()
        {
            return View();
        }

        [HttpGet]
        public ActionResult PanelLista()
        {
            return View();
        }

        public ActionResult PanelMantener()
        {
            return View(new ClienteModel { });
        }

        public ActionResult PanelTest()
        {
            return View();
        }

        public JsonResult Consultar(string texto)
        {
            try
            {
                var clientesResult = (List<ClienteModel>)null;
                if (ModelState.IsValid)
                {
                    clientesResult = _clienteProvider.SelectByConsultora(userData.PaisID, userData.ConsultoraID);
                }
                if (clientesResult !=null && texto.Trim().Length > 0)
                    clientesResult = clientesResult.FindAll(x => x.NombreCliente.Trim().ToUpper().Contains(texto.Trim().ToUpper()));

                return Json(new ConsultarResult(clientesResult), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(
                    ex,
                    userData.CodigoConsultora,
                    userData.CodigoISO,
                    "TusClientesController.Consultar"
                    );
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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "TusClientesController.Mantener");
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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "TusClientesController.Mantener");
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