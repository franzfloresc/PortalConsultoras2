using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEtiqueta
    {
        [DataMember]
        public int EtiquetaID { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public int Estado { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int CodigoGeneral { get; set; }

        public BEEtiqueta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "EtiquetaID"))
                EtiquetaID = Convert.ToInt32(row["EtiquetaID"]);

            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);

            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToInt32(row["Estado"]);

            if (DataRecord.HasColumn(row, "CodigoGeneral"))
                CodigoGeneral = Convert.ToInt32(row["CodigoGeneral"]);
        }
    }

}
