using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Controllers
{
    public class FechasFacturacionController : BaseController
    {
        private readonly EstadoCuentaProvider provider = new EstadoCuentaProvider();
        public async Task<ActionResult> Index()
        {
            BEFechaFacturacion objBEFechaFacturacion = await provider.GetFechasFacturacionConsultora(userData);
            return View(objBEFechaFacturacion);
        }

    }
}