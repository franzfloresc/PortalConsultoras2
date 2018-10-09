using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.SessionManager.MasGanadoras
{
    public interface IMasGanadoras
    {
        MasGanadorasModel GetModel();
        void SetModel(MasGanadorasModel model);
    }
}
