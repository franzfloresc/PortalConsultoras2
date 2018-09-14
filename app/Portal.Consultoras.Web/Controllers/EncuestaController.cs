using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EncuestaController : BaseController
    {
        public ActionResult Index()
        {
            string url = string.Format("http://belcorpencuestas.azurewebsites.net/?PA={0}&CO={1}&CA={2}", userData.CodigoISO, userData.CodigoConsultora, userData.CampaniaID.ToString());
            return Redirect(url);
        }

    }
}
