using System;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoComentarioDetalle
    {
        [DataMember]
        public long ProdComentarioDetalleId { get; set; }

        [DataMember]
        public int ProdComentarioResumenId { get; set; }

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
        public string CodigoSAP { get; set; }

        [DataMember]
        public string CodigoGenerico { get; set; }

        public BEProductoComentarioDetalle()
        { }

        public BEProductoComentarioDetalle(IDataRecord row)
        {
            if (row.HasColumn("ProdComentarioDetalleId"))
                ProdComentarioDetalleId = Convert.ToInt64(row["ProdComentarioDetalleId"]);

            if (row.HasColumn("ProdComentarioResumenId"))
                ProdComentarioResumenId = Convert.ToInt32(row["ProdComentarioResumenId"]);

            if (row.HasColumn("Valorizado"))
                Valorizado = Convert.ToInt16(row["Valorizado"]);

            if (row.HasColumn("Recomendado"))
                Recomendado = Convert.ToBoolean(row["Recomendado"]);

            if (row.HasColumn("Comentario"))
                Comentario = Convert.ToString(row["Comentario"]);

            if (row.HasColumn("CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (row.HasColumn("CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (row.HasColumn("FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);

            if (row.HasColumn("FechaAprobacion"))
                FechaAprobacion = Convert.ToDateTime(row["FechaAprobacion"]);

            if (row.HasColumn("CodTipoOrigen"))
                CodTipoOrigen = Convert.ToInt32(row["CodTipoOrigen"]);

            if (row.HasColumn("Estado"))
                Estado = Convert.ToInt16(row["Estado"]);
        }
    }
}