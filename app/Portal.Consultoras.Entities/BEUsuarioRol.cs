using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

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
            if (DataRecord.HasColumn(row, "RolID"))
                RolID = Convert.ToInt32(row["RolID"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "RolDescripcion"))
                RolDescripcion = Convert.ToString(row["RolDescripcion"]);
            if (DataRecord.HasColumn(row, "UsuarioNombre"))
                UsuarioNombre = Convert.ToString(row["UsuarioNombre"]);
            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToBoolean(row["Activo"]);
            if (DataRecord.HasColumn(row, "paisID"))
                paisID = Convert.ToInt32(row["paisID"]);
        }
    }
}
