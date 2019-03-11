using System;
using System.Collections.Generic;
using System.Web;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.TempDataManager
{
    internal class TempDataManager : ITempDataManager
    {
        public List<EstrategiaPersonalizadaProductoModel> GetListODD(TempDataDictionary TempData, bool persistencia = false)
        {

            List<EstrategiaPersonalizadaProductoModel> result = null;

            if (TempData["tdListODD"] != null)
            {
                result = (List<EstrategiaPersonalizadaProductoModel>)TempData["tdListODD"];
                if (persistencia)
                {
                    TempData.Keep("tdListODD");
                }
            }

            return result;
        }

        public void SetListODD(TempDataDictionary TempData, List<EstrategiaPersonalizadaProductoModel> listODD)
        {
            TempData["tdListODD"] = listODD;
        }
    }
}