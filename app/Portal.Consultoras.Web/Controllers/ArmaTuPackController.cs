using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [RoutePrefix("ArmaTuPack")]
    public class ArmaTuPackController : BaseController
    {
        public ActionResult Index()
        {
            throw new NotImplementedException();
        }
        [HttpGet()]
        [Route("Detalle/{cuv:int}")]
        public ActionResult Detalle(string cuv)
        {
            if (string.IsNullOrEmpty(cuv)) throw new ArgumentNullException("cuv", "is null or empty.");

            return View();
        }
    }
}