using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCronogramaAnticipado
    {
        public IList<BECronograma> GetCronogramaByCampaniaAnticipado(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            var cronogramas = new List<BECronograma>();
            var DACronograma = new DACronogramaAnticipado(paisID);

            using (IDataReader reader = DACronograma.GetCronogramaByCampania(CampaniaID, ZonaID, TipoCronogramaID))
                while (reader.Read())
                {
                    var cronograma = new BECronograma(reader);
                    cronograma.PaisID = paisID;
                    cronogramas.Add(cronograma);
                }

            return cronogramas;
        }

        public int InsertCronogramaAnticipado(BECronograma cronograma)
        {
            var DACronograma = new DACronogramaAnticipado(cronograma.PaisID);
            return DACronograma.InsCronograma(cronograma);
        }

        public void UpdateCronogramaAnticipado(BECronograma cronograma)
        {
            var DACronograma = new DACronogramaAnticipado(cronograma.PaisID);
            DACronograma.UpdCronograma(cronograma);
        }

        public void DeleteCronogramaAnticipado(BECronograma cronograma)
        {
            var DACronograma = new DACronogramaAnticipado(cronograma.PaisID);
            DACronograma.DelCronograma(cronograma);
        }

        public int InsConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {
            var DACronograma = new DACronogramaAnticipado(paisID);
            return DACronograma.InsConfiguracionConsultoraDA(configuracionConsultoraDA);
        }

        public int GetConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {
            var DACronograma = new DACronogramaAnticipado(paisID);
            return DACronograma.GetConfiguracionConsultoraDA(configuracionConsultoraDA);
        }

        public int GetCronogramaDA(int paisID, DateTime fechaFacturacion)
        {
            var DACronograma = new DACronogramaAnticipado(paisID);
            return DACronograma.GetCronogramaDA(fechaFacturacion);
        }


    }
}
