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
    public class BLCDRWebDatos
    {
        public List<BECDRWebDatos> GetCDRWebDatos(int PaisID, BECDRWebDatos entity)
        {
            var listaEntity = new List<BECDRWebDatos>();

            try
            {
                var DACDRWebDatos = new DACDRWebDatos(PaisID);
                using (IDataReader reader = DACDRWebDatos.GetCDRWebDatos(entity))
                {
                    while (reader.Read())
                    {
                        listaEntity.Add(new BECDRWebDatos(reader));
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
