using System;
using System.Collections.Generic;
using System.Web;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.TempDataManager
{
    internal class TempDataManager : ITempDataManager
    {
        #region Constantes Nombres TempData

        private const string _tdListODD = "tdListODD";
        private const string _tdMobileBaseODD = "tdMobileODDBase";

        #endregion

        private TempDataDictionary _tempData;

        public TempDataManager(TempDataDictionary TempData)
        {
            _tempData = TempData;
        }

        public List<EstrategiaPersonalizadaProductoModel> GetListODD(bool persistencia = false)
        {

            List<EstrategiaPersonalizadaProductoModel> result = null;

            if (_tempData[_tdListODD] != null)
            {
                result = (List<EstrategiaPersonalizadaProductoModel>)_tempData[_tdListODD];
                if (persistencia)
                {
                    _tempData.Keep(_tdListODD);
                }
            }

            return result;
        }

        public void SetListODD(List<EstrategiaPersonalizadaProductoModel> listODD)
        {
            _tempData[_tdListODD] = listODD; 
        }

        public bool ExistTDListODD()
        {
            return _tempData.ContainsKey(_tdListODD);
        }

        public void RemoveTDListODD()
        {
            _tempData.Remove(_tdListODD);
        }

        public void SetMobileBaseODD(string valor)
        {
            _tempData[_tdMobileBaseODD] = valor;
        }

        public string GetMobileBaseODD()
        {
            return (_tempData[_tdMobileBaseODD] ?? "").ToString();
        }

        public bool ExistMobileBaseODD()
        {
            return _tempData.ContainsKey(_tdMobileBaseODD);
        }

        public void RemoveMobileBaseODD()
        {
            _tempData.Remove(_tdMobileBaseODD);
        }
    }
}