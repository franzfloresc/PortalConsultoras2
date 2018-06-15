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
            if (DataRecord.HasColumn(row, "IdComprobantePercepcion"))
                IdComprobantePercepcion = Convert.ToInt32(row["IdComprobantePercepcion"]);
            if (DataRecord.HasColumn(row, "IdNumeroAutorizacion"))
                IdNumeroAutorizacion = Convert.ToInt64(row["IdNumeroAutorizacion"]);
            if (DataRecord.HasColumn(row, "NumeroComprobanteSerie"))
                NumeroComprobanteSerie = Convert.ToString(row["NumeroComprobanteSerie"]);
            if (DataRecord.HasColumn(row, "FechaEmision"))
                FechaEmision = Convert.ToDateTime(row["FechaEmision"]);
            if (DataRecord.HasColumn(row, "ImportePercepcion"))
                ImportePercepcion = Convert.ToDecimal(row["ImportePercepcion"]);
            if (DataRecord.HasColumn(row, "NombreAgentePerceptor"))
                NombreAgentePerceptor = Convert.ToString(row["NombreAgentePerceptor"]);
            if (DataRecord.HasColumn(row, "RUCAgentePerceptor"))
                RUCAgentePerceptor = Convert.ToString(row["RUCAgentePerceptor"]);
            if (DataRecord.HasColumn(row, "DireccionAgentePerceptor"))
                DireccionAgentePerceptor = Convert.ToString(row["DireccionAgentePerceptor"]);
            if (DataRecord.HasColumn(row, "EstadoComprobante"))
                EstadoComprobante = Convert.ToString(row["EstadoComprobante"]);
            if (DataRecord.HasColumn(row, "NumeroLote"))
                NumeroLote = Convert.ToString(row["NumeroLote"]);
            if (DataRecord.HasColumn(row, "EstadoActivo"))
                EstadoActivo = Convert.ToInt32(row["EstadoActivo"]);
            if (DataRecord.HasColumn(row, "NumeroComprobanteCorrelativo"))
                NumeroComprobanteCorrelativo = Convert.ToString(row["NumeroComprobanteCorrelativo"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            if (NumeroComprobanteSerie != null && NumeroComprobanteCorrelativo != null)
            {
                NumeroComprobante = NumeroComprobanteSerie + "-" + NumeroComprobanteCorrelativo;
            }
        }
    }
}
