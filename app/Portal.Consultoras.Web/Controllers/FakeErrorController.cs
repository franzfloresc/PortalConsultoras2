using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class FakeErrorController : Controller
    {
        // GET: FakeError
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult InternalServerError()
        {
            InternalError();

            return new  EmptyResult();
        }
        [HttpGet]
        [Authorize]
        public ActionResult AutorizeError()
        {
            HttpContext.Response.StatusCode = 401;

            return new EmptyResult();
        }
        [HttpGet]
        public ActionResult TimeOutError()
        {
            System.Threading.Thread.Sleep(111000);

            return new EmptyResult();
        }

        public HttpStatusCodeResult Error(int id)
        {
            HttpStatusCodeResult result = null;

            HttpStatusCode StatusCode = (HttpStatusCode)id;
            result = new HttpStatusCodeResult(StatusCode);
            return result;
        }

        void InternalError()
        {
            throw new DivideByZeroException();
        }
    }
}