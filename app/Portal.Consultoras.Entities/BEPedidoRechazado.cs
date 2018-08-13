using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoRechazado
    {
        [DataMember]
        public int IdPedidoRechazado { get; set; }
        [DataMember]
        public int IdProcesoPedidoRechazado { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public string Valor { get; set; }
        [DataMember]
        public bool RequiereGestion { get; set; }
        [DataMember]
        public bool Procesado { get; set; }
        [DataMember]
        public bool Rechazado { get; set; }

        public BEPedidoRechazado()
        { }

        public BEPedidoRechazado(IDataRecord row)
        {
            IdPedidoRechazado = row.ToInt32("IdPedidoRechazado");
            IdProcesoPedidoRechazado = row.ToInt32("IdProcesoPedidoRechazado");
            Campania = row.ToString("Campania");
            CodigoConsultora = row.ToString("CodigoConsultora");
            MotivoRechazo = row.ToString("MotivoRechazo", "").ToUpper().Trim();
            Valor = row.ToString("Valor");
            RequiereGestion = row.ToBoolean("RequiereGestion");
            Procesado = row.ToBoolean("Procesado");
            Rechazado = row.ToBoolean("Rechazado");
        }
    }
}
