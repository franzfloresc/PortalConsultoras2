using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLCDRParametria
    {
        public List<BECDRParametria> GetCDRParametria(int PaisID, BECDRParametria entity)
        {
            var listaEntity = new List<BECDRParametria>();

            try
            {
                var dacdrParametria = new DACDRParametria(PaisID);
                using (IDataReader reader = dacdrParametria.GetCDRParametria(entity))
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