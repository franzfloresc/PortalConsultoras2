using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoRechazadoSicc
    {
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BEPedidoRechazadoSicc(IDataRecord row)
        {
            Campania = row.ToString("Campania");
            CodigoConsultora = row.ToString("CodigoConsultora");
            MotivoRechazo = row.ToString("MotivoRechazo");
            Valor = row.ToString("Valor");
        }
    }
}
