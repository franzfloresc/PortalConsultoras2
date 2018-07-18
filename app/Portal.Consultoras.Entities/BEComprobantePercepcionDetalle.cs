using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEComprobantePercepcionDetalle
    {

        [DataMember]
        public int IdComprobantePercepcionDetalle { set; get; }
        [DataMember]
        public string TipoDocumento { set; get; }
        [DataMember]
        public string NumeroDocumentoSerie { set; get; }
        [DataMember]
        public string NumeroDocumentoCorrelativo { set; get; }
        [DataMember]
        public DateTime FechaEmisionDocumento { set; get; }
        [DataMember]
        public decimal Monto { get; set; }
        [DataMember]
        public decimal PorcentajePercepcion { get; set; }
        [DataMember]
        public decimal ImportePercepcion { get; set; }
        [DataMember]
        public decimal MontoTotal { get; set; }
        [DataMember]
        public int EstadoActivo { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int IdComprobantePercepcion { get; set; }

        public BEComprobantePercepcionDetalle()
        {
        }

        public BEComprobantePercepcionDetalle(IDataRecord row)
        {
            IdComprobantePercepcionDetalle = row.ToInt32("IdComprobantePercepcionDetalle");
            TipoDocumento = row.ToString("TipoDocumento");
            NumeroDocumentoSerie = row.ToString("NumeroDocumentoSerie");
            NumeroDocumentoCorrelativo = row.ToString("NumeroDocumentoCorrelativo");
            FechaEmisionDocumento = row.ToDateTime("FechaEmisionDocumento");
            Monto = row.ToDecimal("Monto");
            PorcentajePercepcion = row.ToDecimal("PorcentajePercepcion");
            ImportePercepcion = row.ToDecimal("ImportePercepcion");
            MontoTotal = row.ToDecimal("MontoTotal");
            EstadoActivo = row.ToInt32("EstadoActivo");
            PaisID = row.ToInt32("PaisID");
            IdComprobantePercepcion = row.ToInt32("IdComprobantePercepcion");
        }
    }
}
