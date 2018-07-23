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
            RolID = row.ToInt32("RolID");
            Descripcion = row.ToString("Descripcion");
            Activo = row.ToBoolean("Activo");
            Sistema = row.ToInt32("Sistema");
        }
    }
}
