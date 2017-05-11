using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioExterno
    {
        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string Proveedor { get; set; }

        [DataMember]
        public string IdAplicacion { get; set; }

        [DataMember]
        public string Login { get; set; }

        [DataMember]
        public string Nombres { get; set; }

        [DataMember]
        public string Apellidos { get; set; }

        [DataMember]
        public string FechaNacimiento { get; set; }

        [DataMember]
        public string Correo { get; set; }

        [DataMember]
        public string Genero { get; set; }

        [DataMember]
        public string Ubicacion { get; set; }

        [DataMember]
        public string LinkPerfil { get; set; }

        [DataMember]
        public string FotoPerfil { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public int Estado { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string CodigoISO { get; set; }

        public BEUsuarioExterno()
        {

        }

        public BEUsuarioExterno(IDataRecord row)
        {
            CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            Proveedor = Convert.ToString(row["Proveedor"]);
            IdAplicacion = Convert.ToString(row["IdAplicacion"]);

            if (row.HasColumn("Login"))
                Login = Convert.ToString(row["Login"]);
            if (row.HasColumn("Nombres"))
                Nombres = Convert.ToString(row["Nombres"]);
            if (row.HasColumn("Apellidos"))
                Apellidos = Convert.ToString(row["Apellidos"]);
            if (row.HasColumn("FechaNacimiento") && row["FechaNacimiento"] != DBNull.Value)
                FechaNacimiento = Convert.ToString(row["FechaNacimiento"]);
            if (row.HasColumn("Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (row.HasColumn("Genero"))
                Genero = Convert.ToString(row["Genero"]);
            if (row.HasColumn("Ubicacion"))
                Ubicacion = Convert.ToString(row["Ubicacion"]);
            if (row.HasColumn("LinkPerfil") )
                LinkPerfil = Convert.ToString(row["LinkPerfil"]);
            if (row.HasColumn("FotoPerfil"))
                FotoPerfil = Convert.ToString(row["FotoPerfil"]);
            if (row.HasColumn("FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (row.HasColumn("Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToInt16(row["Estado"]);

        }

    }
}
