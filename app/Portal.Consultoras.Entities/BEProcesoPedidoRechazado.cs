using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProcesoPedidoRechazado
    {
        [DataMember]
        public int IdProcesoPedidoRechazado { get; set; }
        [DataMember]
        public DateTime Fecha { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public string Mensaje { get; set; }

        [DataMember]
        public List<BEPedidoRechazado> olstBEPedidoRechazado { get; set; }

        public BEProcesoPedidoRechazado()
        { }

        public BEProcesoPedidoRechazado(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdProcesoPedidoRechazado"))
                IdProcesoPedidoRechazado = Convert.ToInt32(row["IdProcesoPedidoRechazado"]);
            if (DataRecord.HasColumn(row, "Fecha"))
                Fecha = Convert.ToDateTime(row["Fecha"]);
            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToString(row["Estado"]);
            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);

            olstBEPedidoRechazado = new List<BEPedidoRechazado>();
        }
    }
}
