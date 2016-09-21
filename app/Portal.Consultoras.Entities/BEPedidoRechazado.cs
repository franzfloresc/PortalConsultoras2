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

        public BEPedidoRechazado()
        { }

        public BEPedidoRechazado(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdPedidoRechazado"))
                IdPedidoRechazado = Convert.ToInt32(row["IdPedidoRechazado"]);
            if (DataRecord.HasColumn(row, "IdProcesoPedidoRechazado"))
                IdProcesoPedidoRechazado = Convert.ToInt32(row["IdProcesoPedidoRechazado"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "MotivoRechazo"))
                MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            if (DataRecord.HasColumn(row, "Valor"))
                Valor = Convert.ToString(row["Valor"]);
            if (DataRecord.HasColumn(row, "RequiereGestion"))
                RequiereGestion = Convert.ToBoolean(row["RequiereGestion"]);
            if (DataRecord.HasColumn(row, "Procesado"))
                Procesado = Convert.ToBoolean(row["Procesado"]);
        }
    }
}
