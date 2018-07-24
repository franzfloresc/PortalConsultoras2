using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioRol
    {
        [DataMember]
        public int RolID { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string RolDescripcion { get; set; }

        [DataMember]
        public string UsuarioNombre { get; set; }

        [DataMember]
        public bool Activo { get; set; }

        [DataMember]
        public int paisID { get; set; }

        public BEUsuarioRol()
        { }

        public BEUsuarioRol(IDataRecord row)
        {
            RolID = row.ToInt32("RolID");
            CodigoUsuario = row.ToString("CodigoUsuario");
            RolDescripcion = row.ToString("RolDescripcion");
            UsuarioNombre = row.ToString("UsuarioNombre");
            Activo = row.ToBoolean("Activo");
            paisID = row.ToInt32("paisID");
        }
    }
}
