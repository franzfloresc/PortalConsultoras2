using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BERol
    {
        [DataMember]
        public int RolID { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public bool Activo { get; set; }

        [DataMember]
        public int? PermisoID { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int Sistema { get; set; }

        public BERol()
        { }

        public BERol(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "RolID"))
                RolID = Convert.ToInt32(row["RolID"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToBoolean(row["Activo"]);
            if (DataRecord.HasColumn(row, "Sistema"))
                Sistema = Convert.ToInt32(row["Sistema"]);

        }
    }
}
