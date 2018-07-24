using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoComentario
    {
        [DataMember]
        public int ProdComentarioId { get; set; }

        [DataMember]
        public string CodigoSap { get; set; }

        [DataMember]
        public string CodigoGenerico { get; set; }

        [DataMember]
        public int CantAprobados { get; set; }

        [DataMember]
        public int CantRecomendados { get; set; }

        [DataMember]
        public int PromValorizado { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public Int16 Estado { get; set; }

        public BEProductoComentario()
        { }

        public BEProductoComentario(IDataRecord row)
        {
            ProdComentarioId = row.ToInt32("ProdComentarioId");
            CodigoSap = row.ToString("CodigoSap");
            CodigoGenerico = row.ToString("CodigoGenerico");
            CantAprobados = row.ToInt32("CantAprobados");
            CantRecomendados = row.ToInt32("CantRecomendados");
            PromValorizado = row.ToInt32("PromValorizado");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            Estado = row.ToInt16("Estado");
        }
    }
}
