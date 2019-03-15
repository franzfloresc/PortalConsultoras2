using System;
using System.Collections.Generic;
using System.Web;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.TempDataManager
{
    internal class TempDataManager : ITempDataManager
    {
        private TempDataDictionary _tempData;

        public TempDataManager(TempDataDictionary TempData)
        {
            _tempData = TempData;
        }

        public List<EstrategiaPersonalizadaProductoModel> GetListODD(bool persistencia = false)
        {

            List<EstrategiaPersonalizadaProductoModel> result = null;

            if (_tempData["tdListODD"] != null)
            {
                result = (List<EstrategiaPersonalizadaProductoModel>)_tempData["tdListODD"];
                if (persistencia)
                {
                    _tempData.Keep("tdListODD");
                }
            }

            return result;
        }

        public void SetListODD(List<EstrategiaPersonalizadaProductoModel> listODD)
        {
            _tempData["tdListODD"] = listODD;
        }
    }
}