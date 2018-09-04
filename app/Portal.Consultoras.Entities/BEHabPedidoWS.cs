using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEHabPedidoCabWS
    {
        [DataMember]
        public string CodigoPais { get; set; }
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public int PedidoId { get; set; }
        [DataMember]
        public List<BEHabPedidoDetWS> DetallePedido { get; set; }

        public BEHabPedidoCabWS()
        { }

        public BEHabPedidoCabWS(IDataRecord row)
        {
            
                CodigoPais = row.ToString("CodigoPais");
            
                Campania = row.ToInt32("Campania");
            
                CodigoConsultora = row.ToString("CodigoConsultora");
            
                CodigoZona = row.ToString("CodigoZona");
            
                FechaRegistro = row.ToDateTime("FechaRegistro");
            
                ImporteTotal = row.ToDecimal("ImporteTotal");
            
                PedidoId = row.ToInt32("PedidoId");
        }
    }

    [DataContract]
    public class BEHabPedidoDetWS
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Cantidad { get; set; }

        public BEHabPedidoDetWS()
        { }

        public BEHabPedidoDetWS(IDataRecord row)
        {
            
                CUV = row.ToString("CUV");
            
                Cantidad = row.ToInt32("Cantidad");
        }
    }
}
