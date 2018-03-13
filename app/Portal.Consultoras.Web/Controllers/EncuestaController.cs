using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EncuestaController : BaseController
    {
        public ActionResult Index()
        {
            string url = string.Format("http://belcorpencuestas.azurewebsites.net/?PA={0}&CO={1}&CA={2}", UserData().CodigoISO, UserData().CodigoConsultora, UserData().CampaniaID.ToString());
            return Redirect(url);
        }

    }
}
