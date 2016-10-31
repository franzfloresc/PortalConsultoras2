using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWeb
    {
        [DataMember]
        public int CDRWebID { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public DateTime FechaCulminado { get; set; }
        [DataMember]
        public decimal Importe { get; set; }

        public BECDRWeb()
        { }

        public BECDRWeb(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CDRWebID") && row["CDRWebID"] != DBNull.Value) CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (DataRecord.HasColumn(row, "PedidoID") && row["PedidoID"] != DBNull.Value) PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value) CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value) ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value) FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value) Estado = Convert.ToInt32(row["Estado"]);
            if (DataRecord.HasColumn(row, "FechaCulminado") && row["FechaCulminado"] != DBNull.Value) FechaCulminado = Convert.ToDateTime(row["FechaCulminado"]);
            if (DataRecord.HasColumn(row, "Importe") && row["Importe"] != DBNull.Value) Importe = Convert.ToDecimal(row["Importe"]);
        }
    }
}
