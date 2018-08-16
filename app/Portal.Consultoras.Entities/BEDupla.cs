using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEDupla
    {
        public BEDupla(IDataRecord row)
        {
            CodigoUsuario = row.ToString("CodigoUsuario");
            Nombre = row.ToString("Nombre");
            SegundoNombre = row.ToString("SegundoNombre");
            ApellidoPaterno = row.ToString("ApellidoPaterno");
            ApellidoMaterno = row.ToString("ApellidoMaterno");
            Sobrenombre = row.ToString("Sobrenombre");
            FechaNacimiento = row.ToDateTime("FechaNacimiento");
            eMail = row.ToString("eMail");
            Sexo = row.ToString("Sexo");
            Telefono = row.ToString("Telefono");
            Celular = row.ToString("Celular");
            Direccion = row.ToString("Direccion");
            Activo = row.ToBoolean("Activo");
        }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string SegundoNombre { get; set; }

        [DataMember]
        public string ApellidoPaterno { get; set; }

        [DataMember]
        public string ApellidoMaterno { get; set; }

        [DataMember]
        public string Sobrenombre { get; set; }

        [DataMember]
        public DateTime FechaNacimiento { get; set; }

        [DataMember]
        public string eMail { get; set; }

        [DataMember]
        public string Sexo { get; set; }

        [DataMember]
        public string Telefono { get; set; }

        [DataMember]
        public string Celular { get; set; }

        [DataMember]
        public string Direccion { get; set; }

        [DataMember]
        public bool Activo { get; set; }

        [DataMember]
        public int PaisID { get; set; }

    }
}
