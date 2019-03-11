using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.TempDataManager
{
    internal interface ITempDataManager
    {
        List<EstrategiaPersonalizadaProductoModel> GetListODD(TempDataDictionary TempData, bool persistencia);

        void SetListODD(TempDataDictionary TempData, List<EstrategiaPersonalizadaProductoModel> listODD);
    }
}
