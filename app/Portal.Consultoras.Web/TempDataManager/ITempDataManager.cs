using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.TempDataManager
{
    public interface ITempDataManager
    {
        List<EstrategiaPersonalizadaProductoModel> GetListODD(bool persistencia = false);

        void SetListODD(List<EstrategiaPersonalizadaProductoModel> listODD);

        bool ExistTDListODD();

        void RemoveTDListODD();
    }
}
