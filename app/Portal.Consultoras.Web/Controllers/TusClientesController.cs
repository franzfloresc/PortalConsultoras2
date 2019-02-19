using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.TusClientes;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

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
                if (clientesResult != null && clientesResult.Any() && texto.Trim().Length > 0)
                    clientesResult = clientesResult.FindAll(x => x.Nombre.Trim().ToUpper().Contains(texto.Trim().ToUpper()));

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
        public JsonResult Mantener(ClienteModel client)
        {
            try
            {
                if (client == null) throw new ArgumentNullException("client", "client parameter is null");

                var clienteNuevo = client.ClienteID == 0;

                var response = _clienteProvider.SaveDB(userData.PaisID, userData.ConsultoraID, client);

                if (response.CodigoRespuesta == Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    return Json(new
                    {
                        success = true,
                        message = clienteNuevo ? "Se registró con éxito tu cliente." : "Se actualizó con éxito tu cliente.",
                        ClienteID = response.ClienteID,
                        CodigoCliente = response.CodigoCliente,
                        NombreCompleto = response.NombreCompleto
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = clienteNuevo ? "Error al registrar cliente." : "Error al actualizar cliente."
                    });
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "TusClientesController.Mantener");
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    Trycatch = Common.LogManager.GetMensajeError(ex)
                });
            }
        }

        [HttpPost]
        public JsonResult Eliminar(int clienteId)
        {
            try
            {
                var mensaje = _clienteProvider.Eliminar(userData.PaisID,userData.ConsultoraID,clienteId) ? 
                    "Se eliminó satisfactoriamente el registro." : 
                    "No es posible eliminar al cliente dado que se encuentra asociado a un pedido.";

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    extra = ""
                });

            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "TusClientesController.Eliminar");
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