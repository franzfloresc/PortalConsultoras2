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
            if (DataRecord.HasColumn(row, "OfertaID"))
                OfertaID = Convert.ToInt32(row["OfertaID"]);

            if (DataRecord.HasColumn(row, "CodigoOferta"))
                CodigoOferta = Convert.ToString(row["CodigoOferta"]);

            if (DataRecord.HasColumn(row, "DescripcionOferta"))
                DescripcionOferta = Convert.ToString(row["DescripcionOferta"]);

            if (DataRecord.HasColumn(row, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(row["CodigoPrograma"]);
        }
    }
}
