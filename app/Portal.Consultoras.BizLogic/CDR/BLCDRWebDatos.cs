using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLCDRWebDatos
    {
        public List<BECDRWebDatos> GetCDRWebDatos(int PaisID, BECDRWebDatos entity)
        {
            var listaEntity = new List<BECDRWebDatos>();

            try
            {
                var daCdrWebDatos = new DACDRWebDatos(PaisID);
                using (IDataReader reader = daCdrWebDatos.GetCDRWebDatos(entity))
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
