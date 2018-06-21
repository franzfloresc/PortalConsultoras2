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
            if (DataRecord.HasColumn(row, "IdComprobantePercepcionDetalle"))
                IdComprobantePercepcionDetalle = Convert.ToInt32(row["IdComprobantePercepcionDetalle"]);
            if (DataRecord.HasColumn(row, "TipoDocumento"))
                TipoDocumento = Convert.ToString(row["TipoDocumento"]);
            if (DataRecord.HasColumn(row, "NumeroDocumentoSerie"))
                NumeroDocumentoSerie = Convert.ToString(row["NumeroDocumentoSerie"]);
            if (DataRecord.HasColumn(row, "NumeroDocumentoCorrelativo"))
                NumeroDocumentoCorrelativo = Convert.ToString(row["NumeroDocumentoCorrelativo"]);
            if (DataRecord.HasColumn(row, "FechaEmisionDocumento"))
                FechaEmisionDocumento = Convert.ToDateTime(row["FechaEmisionDocumento"]);
            if (DataRecord.HasColumn(row, "Monto"))
                Monto = Convert.ToDecimal(row["Monto"]);
            if (DataRecord.HasColumn(row, "PorcentajePercepcion"))
                PorcentajePercepcion = Convert.ToDecimal(row["PorcentajePercepcion"]);
            if (DataRecord.HasColumn(row, "ImportePercepcion"))
                ImportePercepcion = Convert.ToDecimal(row["ImportePercepcion"]);
            if (DataRecord.HasColumn(row, "MontoTotal"))
                MontoTotal = Convert.ToDecimal(row["MontoTotal"]);
            if (DataRecord.HasColumn(row, "EstadoActivo"))
                EstadoActivo = Convert.ToInt32(row["EstadoActivo"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "IdComprobantePercepcion"))
                IdComprobantePercepcion = Convert.ToInt32(row["IdComprobantePercepcion"]);
        }
    }
}
