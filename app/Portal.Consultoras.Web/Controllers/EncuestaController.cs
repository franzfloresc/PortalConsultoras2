using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EncuestaController : BaseController
    {
        //
        // GET: /Encuesta/

        public ActionResult Index()
        {
            string URL = string.Format("http://belcorpencuestas.azurewebsites.net/?PA={0}&CO={1}&CA={2}", UserData().CodigoISO, UserData().CodigoConsultora, UserData().CampaniaID.ToString());
            return Redirect(URL);
        }

    }
}
