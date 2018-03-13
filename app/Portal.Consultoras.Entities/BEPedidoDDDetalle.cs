namespace Portal.Consultoras.Entities
{
    using Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEPedidoDDDetalle
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int PedidoID { get; set; }

        [DataMember]
        public int PedidoDetalleID { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public decimal ImporteTotal { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public bool IndicadorActivo { get; set; }

        [DataMember]
        public string CodigoUsuarioCreacion { get; set; }

        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public bool IndicadorEnviado { get; set; }

        [DataMember]
        public DateTime FechaEnvio { get; set; }
        public BEPedidoDDDetalle()
        { }

        public BEPedidoDDDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleID"))
                PedidoDetalleID = Convert.ToInt32(row["PedidoDetalleID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "IndicadorActivo"))
                IndicadorActivo = Convert.ToBoolean(row["IndicadorActivo"]);
            if (DataRecord.HasColumn(row, "CodigoUsuarioCreacion"))
                CodigoUsuarioCreacion = Convert.ToString(row["CodigoUsuarioCreacion"]);
            if (DataRecord.HasColumn(row, "CodigoUsuarioModificacion"))
                CodigoUsuarioModificacion = Convert.ToString(row["CodigoUsuarioModificacion"]);
            if (DataRecord.HasColumn(row, "FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "IndicadorEnviado"))
                IndicadorEnviado = Convert.ToBoolean(row["IndicadorEnviado"]);
            if (DataRecord.HasColumn(row, "FechaEnvio"))
                FechaEnvio = Convert.ToDateTime(row["FechaEnvio"]);
        }
    }
}
