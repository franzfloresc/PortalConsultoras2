using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoComentarioDetalle : BEPaging
    {
        [DataMember]
        public long ProdComentarioDetalleId { get; set; }

        [DataMember]
        public int ProdComentarioId { get; set; }

        [DataMember]
        public Int16 Valorizado { get; set; }

        [DataMember]
        public bool Recomendado { get; set; }

        [DataMember]
        public string Comentario { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public DateTime FechaAprobacion { get; set; }

        [DataMember]
        public int CodTipoOrigen { get; set; }

        [DataMember]
        public Int16 Estado { get; set; }

        [DataMember]
        public string CodigoSap { get; set; }

        [DataMember]
        public string CodigoGenerico { get; set; }

        [DataMember]
        public string URLFotoConsultora { get; set; }

        [DataMember]
        public string NombreConsultora { get; set; }

        public BEProductoComentarioDetalle()
        { }

        public BEProductoComentarioDetalle(IDataRecord row)
        {
            ProdComentarioDetalleId = row.ToInt64("ProdComentarioDetalleId");
            ProdComentarioId = row.ToInt32("ProdComentarioId");
            Valorizado = row.ToInt16("Valorizado");
            Recomendado = row.ToBoolean("Recomendado");
            Comentario = row.ToString("Comentario");
            CodigoConsultora = row.ToString("CodigoConsultora");
            CampaniaID = row.ToInt32("CampaniaID");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            FechaAprobacion = row.ToDateTime("FechaAprobacion");
            CodTipoOrigen = row.ToInt32("CodTipoOrigen");
            Estado = row.ToInt16("Estado");
            URLFotoConsultora = row.ToString("URLFotoConsultora");
            NombreConsultora = row.ToString("NombreConsultora");
            if (row.HasColumn("TotalFilas"))
                RowsCount = Convert.ToInt32(row["TotalFilas"]);
        }
    }
}
