using Portal.Consultoras.Data;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.BizLogic
{
    public class BLPalabraInvalida
    {
        public IList<string> GetAll()
        {
            var listPalabraInvalida = CacheManager<string>.GetData(ECacheItem.PalabraInvalida);
            if (listPalabraInvalida == null || listPalabraInvalida.Count == 0)
            {
                var dAPalabraInvalida = new DAPalabraInvalida(int.Parse(ConfigurationManager.AppSettings["masterCountry"]));
                listPalabraInvalida = dAPalabraInvalida.GetAll();
                CacheManager<string>.AddData(ECacheItem.PalabraInvalida, listPalabraInvalida, new TimeSpan(1, 1, 0, 0));
            }
            return listPalabraInvalida;
        }
    }
}
