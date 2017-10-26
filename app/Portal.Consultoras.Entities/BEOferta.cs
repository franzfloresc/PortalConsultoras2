using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOferta
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int OfertaID { get; set; }

        [DataMember]
        public int TipoEstrategiaID { get; set; }

        [DataMember]
        public string CodigoOferta { get; set; }

        [DataMember]
        public string DescripcionOferta { get; set; }

        [DataMember]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public string CodigoPrograma { get; set; }

        public BEOferta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OfertaID") && row["OfertaID"] != DBNull.Value)
                OfertaID = Convert.ToInt32(row["OfertaID"]);

            if (DataRecord.HasColumn(row, "CodigoOferta") && row["CodigoOferta"] != DBNull.Value)
                CodigoOferta = row["CodigoOferta"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionOferta") && row["DescripcionOferta"] != DBNull.Value)
                DescripcionOferta = row["DescripcionOferta"].ToString();

            if (DataRecord.HasColumn(row, "CodigoPrograma") && row["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = row["CodigoPrograma"].ToString();
        }
    }
}
