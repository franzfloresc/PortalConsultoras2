using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ComunController : BaseController
    {
   
        [HttpPost]
        public ActionResult InsertarLogDymnamo(InLogUsabilidadModel Log)
        {
            RegistrarLogDynamoDB(Log);
            return Json(new 
            {
                success = true,
                message = "Ok."
            });
        }
    }
}