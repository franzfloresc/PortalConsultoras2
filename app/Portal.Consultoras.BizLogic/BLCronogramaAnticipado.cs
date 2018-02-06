using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCronogramaAnticipado
    {
        public IList<BECronograma> GetCronogramaByCampaniaAnticipado(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            var cronogramas = new List<BECronograma>();
            var daCronograma = new DACronogramaAnticipado(paisID);

            using (IDataReader reader = daCronograma.GetCronogramaByCampania(CampaniaID, ZonaID, TipoCronogramaID))
                while (reader.Read())
                {
                    var cronograma = new BECronograma(reader) {PaisID = paisID};
                    cronogramas.Add(cronograma);
                }

            return cronogramas;
        }

        public int InsertCronogramaAnticipado(BECronograma cronograma)
        {
            var daCronograma = new DACronogramaAnticipado(cronograma.PaisID);
            return daCronograma.InsCronograma(cronograma);
        }

        public void UpdateCronogramaAnticipado(BECronograma cronograma)
        {
            var daCronograma = new DACronogramaAnticipado(cronograma.PaisID);
            daCronograma.UpdCronograma(cronograma);
        }

        public void DeleteCronogramaAnticipado(BECronograma cronograma)
        {
            var daCronograma = new DACronogramaAnticipado(cronograma.PaisID);
            daCronograma.DelCronograma(cronograma);
        }

        public int InsConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {
            var daCronograma = new DACronogramaAnticipado(paisID);
            return daCronograma.InsConfiguracionConsultoraDA(configuracionConsultoraDA);
        }

        public int GetConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {
            var daCronograma = new DACronogramaAnticipado(paisID);
            return daCronograma.GetConfiguracionConsultoraDA(configuracionConsultoraDA);
        }

        public int GetCronogramaDA(int paisID, DateTime fechaFacturacion)
        {
            var daCronograma = new DACronogramaAnticipado(paisID);
            return daCronograma.GetCronogramaDA(fechaFacturacion);
        }


    }
}
