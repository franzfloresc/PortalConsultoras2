using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLEscalaDescuento
    {
        public List<BEEscalaDescuento> GetEscalaDescuento(int paisID)
        {
            List<BEEscalaDescuento> lstEscalaDescuento = null;
            DAEscalaDescuento DAEscalaDescuento = new DAEscalaDescuento(paisID);

            try
            {
                List<BEEscalaDescuento> lstEscalaDescuentoTemp = new List<BEEscalaDescuento>();
                using (IDataReader reader = DAEscalaDescuento.GetEscalaDescuento())
                    while (reader.Read())
                    {
                        var entidad = new BEEscalaDescuento(reader);
                        lstEscalaDescuentoTemp.Add(entidad);
                    }

                lstEscalaDescuento = new List<BEEscalaDescuento>();
                if (lstEscalaDescuentoTemp.Count > 0)
                {
                    lstEscalaDescuento.AddRange((List<BEEscalaDescuento>)lstEscalaDescuentoTemp);
                }
            }
            catch (Exception) { throw; }

            return lstEscalaDescuento;
        }
    }
}
