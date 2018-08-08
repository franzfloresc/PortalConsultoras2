using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEComprobantePercepcion
    {
        [DataMember]
        public int IdComprobantePercepcion { set; get; }
        [DataMember]
        public Int64 IdNumeroAutorizacion { set; get; }
        [DataMember]
        public string NumeroComprobanteSerie { set; get; }
        [DataMember]
        public DateTime FechaEmision { set; get; }
        [DataMember]
        public decimal ImportePercepcion { set; get; }
        [DataMember]
        public string NombreAgentePerceptor { get; set; }
        [DataMember]
        public string RUCAgentePerceptor { get; set; }
        [DataMember]
        public string DireccionAgentePerceptor { get; set; }
        [DataMember]
        public string EstadoComprobante { get; set; }
        [DataMember]
        public string NumeroLote { get; set; }
        [DataMember]
        public int EstadoActivo { get; set; }
        [DataMember]
        public string NumeroComprobanteCorrelativo { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public string NumeroComprobante { get; set; }

        public BEComprobantePercepcion()
        {
        }

        public BEComprobantePercepcion(IDataRecord row)
        {
            IdComprobantePercepcion = row.ToInt32("IdComprobantePercepcion");
            IdNumeroAutorizacion = row.ToInt64("IdNumeroAutorizacion");
            NumeroComprobanteSerie = row.ToString("NumeroComprobanteSerie");
            FechaEmision = row.ToDateTime("FechaEmision");
            ImportePercepcion = row.ToDecimal("ImportePercepcion");
            NombreAgentePerceptor = row.ToString("NombreAgentePerceptor");
            RUCAgentePerceptor = row.ToString("RUCAgentePerceptor");
            DireccionAgentePerceptor = row.ToString("DireccionAgentePerceptor");
            EstadoComprobante = row.ToString("EstadoComprobante");
            NumeroLote = row.ToString("NumeroLote");
            EstadoActivo = row.ToInt32("EstadoActivo");
            NumeroComprobanteCorrelativo = row.ToString("NumeroComprobanteCorrelativo");
            PaisID = row.ToInt32("PaisID");
            ConsultoraID = row.ToInt32("ConsultoraID");

            if (NumeroComprobanteSerie != null && NumeroComprobanteCorrelativo != null)
                NumeroComprobante = NumeroComprobanteSerie + "-" + NumeroComprobanteCorrelativo;
        }
    }
}
