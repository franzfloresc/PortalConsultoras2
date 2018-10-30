using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.SessionManager.MasGanadoras
{
    public class MasGanadoras : IMasGanadoras
    {
        public MasGanadorasModel GetModel()
        {
            return (MasGanadorasModel)HttpContext.Current.Session["MasGanadorasModel"];
        }

        public void SetModel(MasGanadorasModel model)
        {
            HttpContext.Current.Session["MasGanadorasModel"] = model;
        }
    }
}