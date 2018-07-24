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
            CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            Nombre = Convert.ToString(row["Nombre"]);
            SegundoNombre = Convert.ToString(row["SegundoNombre"]);
            ApellidoPaterno = Convert.ToString(row["ApellidoPaterno"]);
            ApellidoMaterno = Convert.ToString(row["ApellidoMaterno"]);
            Sobrenombre = Convert.ToString(row["Sobrenombre"]);
            FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            eMail = Convert.ToString(row["eMail"]);
            Sexo = Convert.ToString(row["Sexo"]);
            Telefono = Convert.ToString(row["Telefono"]);
            Celular = Convert.ToString(row["Celular"]);
            Direccion = Convert.ToString(row["Direccion"]);
            Activo = Convert.ToBoolean(row["Activo"]);
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
