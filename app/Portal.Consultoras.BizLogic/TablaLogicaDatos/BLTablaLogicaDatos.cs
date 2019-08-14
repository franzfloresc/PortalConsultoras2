using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos : ITablaLogicaDatosBusinessLogic
    {
        public List<BETablaLogicaDatos> GetList(int paisID, short tablaLogicaID)
        {
            var lst = new List<BETablaLogicaDatos>();

            try
            {
                using (IDataReader reader = new DATablaLogicaDatos(paisID).GetTablaLogicaDatos(tablaLogicaID))
                {
                    lst = reader.MapToCollection<BETablaLogicaDatos>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, paisID);
            }

            return lst;
        }
        public List<BETablaLogicaDatos> GetListCache(int paisID, short tablaLogicaID)
        {
            return CacheManager<List<BETablaLogicaDatos>>.ValidateDataElement(paisID, ECacheItem.TablaLogicaDatos, tablaLogicaID.ToString(), () => GetList(paisID, tablaLogicaID));
        }

        public bool GetTablaLogicaDatoValorBool(int paisId, short tablaLogicaId, string codigo)
        {
            var valor = GetTablaLogicaDatoValorCodigo(paisId, tablaLogicaId, codigo);
            return valor == "1";
        }

        private string GetTablaLogicaDatoValorCodigo(int paisId, short tablaLogicaId, string codigo)
        {
            var datos = GetListCache(paisId, tablaLogicaId);
            return GetValueByCode(datos, codigo);
        }

        private string GetValueByCode(List<BETablaLogicaDatos> datos, string codigo)
        {
            datos = datos ?? new List<BETablaLogicaDatos>();

            var par = datos.FirstOrDefault(d => d.Codigo == codigo) ?? new BETablaLogicaDatos();

            return Util.Trim(par.Valor);
        }
    }
}