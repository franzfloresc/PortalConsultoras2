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
            CodigoUsuario = row["CodigoUsuario"].ToString();
            Nombre = row["Nombre"].ToString();
            SegundoNombre = row["SegundoNombre"].ToString();
            ApellidoPaterno = row["ApellidoPaterno"].ToString();
            ApellidoMaterno = row["ApellidoMaterno"].ToString();
            Sobrenombre = row["Sobrenombre"].ToString();
            FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            eMail = row["eMail"].ToString();
            Sexo = row["Sexo"].ToString();
            Telefono = row["Telefono"].ToString();
            Celular = row["Celular"].ToString();
            Direccion = row["Direccion"].ToString();
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
