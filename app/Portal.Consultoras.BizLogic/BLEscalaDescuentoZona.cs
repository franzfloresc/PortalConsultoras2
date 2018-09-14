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
    public class BLEscalaDescuentoZona
    {
        public IList<BEEscalaDescuentoZona> ListarEscalaDescuentoZona(int paisID, int campaniaID, string region, string zona)
        {
            List<BEEscalaDescuentoZona> lista = new List<BEEscalaDescuentoZona>();
            try
            {
                var da = new DAEscalaDescuentoZona(paisID);
                using (IDataReader reader = da.ListarEscalaDescuentoZona(campaniaID, region , zona))
                {
                    while (reader.Read())
                    {
                        lista.Add(new BEEscalaDescuentoZona(reader));
                    }
                }
            }
            catch (Exception ex) 
            {
                lista = new List<BEEscalaDescuentoZona>();
            }
            return lista;
        }
    }
}
