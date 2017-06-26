using System;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoComentario
    {
        [DataMember]
        public int ProdComentarioId { get; set; }

        [DataMember]
        public string CodigoSAP { get; set; }

        [DataMember]
        public string CodigoGenerico { get; set; }

        [DataMember]
        public int CantComentarios { get; set; }

        [DataMember]
        public int CantAprobados { get; set; }

        [DataMember]
        public int CantRecomendados { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public Int16 Estado { get; set; }

        [DataMember]
        public Int16 PorcAprobados { get; set; }

        [DataMember]
        public Int16 PorcRecomendados { get; set; }

        public BEProductoComentario()
        { }

        public BEProductoComentario(IDataRecord row)
        {
            if (row.HasColumn("ProdComentarioId"))
                ProdComentarioId = Convert.ToInt32(row["ProdComentarioId"]);

            if (row.HasColumn("CodigoSAP"))
                CodigoSAP = Convert.ToString(row["CodigoSAP"]);

            if (row.HasColumn("CodigoGenerico"))
                CodigoGenerico = Convert.ToString(row["CodigoGenerico"]);

            if (row.HasColumn("CantComentarios"))
                CantComentarios = Convert.ToInt32(row["CantComentarios"]);

            if (row.HasColumn("CantAprobados"))
                CantAprobados = Convert.ToInt32(row["CantAprobados"]);

            if (row.HasColumn("CantRecomendados"))
                CantRecomendados = Convert.ToInt32(row["CantRecomendados"]);

            if (row.HasColumn("FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);

            if (row.HasColumn("Estado"))
                Estado = Convert.ToInt16(row["Estado"]);

            if (row.HasColumn("PorcAprob"))
                PorcAprobados = Convert.ToInt16(row["PorcAprob"]);

            if (row.HasColumn("PorcReco"))
                PorcRecomendados = Convert.ToInt16(row["PorcReco"]);
        }
    }
}