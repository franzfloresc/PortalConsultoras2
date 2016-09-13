using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLParticipantesDemandaAnticipada
    {
        public IList<BEParticipantesDemandaAnticipada> GetParticipantesConfiguracionConsultoraDA(int PaisID, string CodigoCampania, string CodigoConsultora)
        {
            var lista = new List<BEParticipantesDemandaAnticipada>();
            var DAParticipantesDemandaAnticipada = new DAParticipantesDemandaAnticipada(PaisID);

            using (IDataReader reader = DAParticipantesDemandaAnticipada.GetParticipantesConfiguracionConsultoraDA(CodigoCampania, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEParticipantesDemandaAnticipada(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public int InsParticipantesDemandaAnticipada(int paisID, BEParticipantesDemandaAnticipada participantesDemandaAnticipada)
        {
            var DAParticipantesDemandaAnticipada = new DAParticipantesDemandaAnticipada(paisID);
            return DAParticipantesDemandaAnticipada.InsParticipantesDemandaAnticipada(participantesDemandaAnticipada);
        }

        public BEParticipantesDemandaAnticipada GetConsultoraByCodigo(int paisID, string CodigoConsultora)
        {
            BEParticipantesDemandaAnticipada list = null;

            var DAParticipantesDemandaAnticipada = new DAParticipantesDemandaAnticipada(paisID);
            using (IDataReader reader = DAParticipantesDemandaAnticipada.GetConsultoraByCodigo(CodigoConsultora))
                while (reader.Read())
                {
                    list = new BEParticipantesDemandaAnticipada()
                    {
                        ConsultoraID = Convert.ToInt32(reader["ConsultoraID"]),
                        CodigoConsultora = Convert.ToString(reader["CodigoConsultora"]),
                        ZonaID = Convert.ToInt32(reader["ZonaID"]),
                        CodigoZona = Convert.ToString(reader["CodigoZona"]),
                        NombreZona = Convert.ToString(reader["NombreZona"]),
                        NombreCompleto = Convert.ToString(reader["NombreCompleto"]),
                        CodigoCampania = Convert.ToString(reader["CodigoCampania"]),
                        Fecha = Convert.ToDateTime(reader["Fecha"]),
                        TipoConfiguracion = Convert.ToByte(reader["TipoConfiguracion"])
                    };
                }
            return list;
        }
    }
}
