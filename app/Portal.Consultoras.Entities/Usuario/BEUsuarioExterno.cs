using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioExterno
    {
        [DataMember]
        [Column("CodigoUsuario")]
        public string CodigoUsuario { get; set; }

        [DataMember]
        [Column("Proveedor")]
        public string Proveedor { get; set; }

        [DataMember]
        [Column("IdAplicacion")]
        public string IdAplicacion { get; set; }

        [DataMember]
        [Column("Login")]
        public string Login { get; set; }

        [DataMember]
        [Column("Nombres")]
        public string Nombres { get; set; }

        [DataMember]
        [Column("Apellidos")]
        public string Apellidos { get; set; }

        [DataMember]
        [Column("FechaNacimiento")]
        public string FechaNacimiento { get; set; }

        [DataMember]
        [Column("Correo")]
        public string Correo { get; set; }

        [DataMember]
        [Column("Genero")]
        public string Genero { get; set; }

        [DataMember]
        [Column("Ubicacion")]
        public string Ubicacion { get; set; }

        [DataMember]
        [Column("LinkPerfil")]
        public string LinkPerfil { get; set; }

        [DataMember]
        [Column("FotoPerfil")]
        public string FotoPerfil { get; set; }

        [DataMember]
        [Column("FechaRegistro")]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        [Column("Estado")]
        public int Estado { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string CodigoISO { get; set; }

        [DataMember]
        [Column("UsuarioFotoPerfil")]
        public string UsuarioFotoPerfil { get; set; }

        public BEUsuarioExterno()
        {

        }

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEUsuarioExterno(IDataRecord row)
        {
            CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            Proveedor = Convert.ToString(row["Proveedor"]);
            IdAplicacion = Convert.ToString(row["IdAplicacion"]);
            Login = row.ToString("Login");
            Nombres = row.ToString("Nombres");
            Apellidos = row.ToString("Apellidos");
            FechaNacimiento = row.ToString("FechaNacimiento");
            Correo = row.ToString("Correo");
            Genero = row.ToString("Genero");
            Ubicacion = row.ToString("Ubicacion");
            LinkPerfil = row.ToString("LinkPerfil");
            FotoPerfil = row.ToString("FotoPerfil");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            Estado = row.ToInt16("Estado");
        }
    }
}
