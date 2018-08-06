using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoDDWebDetalle
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public Int32 Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public decimal PrecioTotal { get; set; }
        [DataMember]
        public Int32 PedidoDetalleID { get; set; }
        [DataMember]
        public bool IndicadorDigitable { get; set; }
        [DataMember]
        public bool IndicadorMontoMinimo { get; set; }
        [DataMember]
        public bool IndicadorFaltanteAnunciado { get; set; }
        [DataMember]
        public bool IndicadorPromocion { get; set; }
        [DataMember]
        public string UsuarioResponsable { get; set; }
        [DataMember]
        public bool IndicadorEnviado { get; set; }
        [DataMember]
        public DateTime FechaEnvio { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }

        [DataMember]
        public short ClienteID { get; set; }

        public BEPedidoDDWebDetalle()
        { }

        public BEPedidoDDWebDetalle(IDataRecord row)
        {
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("Descripcion");
            Cantidad = row.ToInt32("Cantidad");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            PrecioTotal = row.ToDecimal("PrecioTotal");
            IndicadorDigitable = row.ToBoolean("IndicadorDigitable");
            IndicadorMontoMinimo = row.ToBoolean("IndicadorMontoMinimo");
            IndicadorFaltanteAnunciado = row.ToBoolean("IndicadorFaltanteAnunciado");
            IndicadorPromocion = row.ToBoolean("IndicadorPromocion");
            UsuarioResponsable = row.ToString("UsuarioResponsable");
            PedidoDetalleID = row.ToInt32("PedidoDetalleID");
            IndicadorEnviado = row.ToBoolean("IndicadorEnviado");
            FechaEnvio = row.ToDateTime("FechaEnvio");
            MotivoRechazo = row.ToString("MotivoRechazo");
            ClienteID = row.GetColumn<short>("ClienteID");
        }
    }
}
