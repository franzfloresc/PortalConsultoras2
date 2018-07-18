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
            CampaniaID = row.ToInt32("CampaniaID");
            PedidoID = row.ToInt32("PedidoID");
            PedidoDetalleID = row.ToInt32("PedidoDetalleID");
            ConsultoraID = row.ToInt64("ConsultoraID");
            Cantidad = row.ToInt32("Cantidad");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            CUV = row.ToString("CUV");
            IndicadorActivo = row.ToBoolean("IndicadorActivo");
            CodigoUsuarioCreacion = row.ToString("CodigoUsuarioCreacion");
            CodigoUsuarioModificacion = row.ToString("CodigoUsuarioModificacion");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            IndicadorEnviado = row.ToBoolean("IndicadorEnviado");
            FechaEnvio = row.ToDateTime("FechaEnvio");
        }
    }
}
