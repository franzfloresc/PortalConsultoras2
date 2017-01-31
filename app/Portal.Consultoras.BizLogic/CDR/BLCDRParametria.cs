using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLCDRParametria
    {
        public List<BECDRParametria> GetCDRParametria(int PaisID, BECDRParametria entity)
        {
            var listaEntity = new List<BECDRParametria>();

            try
            {
                var DACDRParametria = new DACDRParametria(PaisID);
                using (IDataReader reader = DACDRParametria.GetCDRParametria(entity))
                {
                    while (reader.Read())
                    {
                        listaEntity.Add(new BECDRParametria(reader));
                    }
                }
                return listaEntity;

            }
            catch (Exception)
            {
                return listaEntity;
            }
        }
    }
}
