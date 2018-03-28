using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos : ITablaLogicaDatosBusinessLogic
    {
        public List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, short TablaLogicaID)
        {
            var lst = new List<BETablaLogicaDatos>();

            try
            {
                using (IDataReader reader = new DATablaLogicaDatos(paisID).GetTablaLogicaDatos(TablaLogicaID))
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
    }
}