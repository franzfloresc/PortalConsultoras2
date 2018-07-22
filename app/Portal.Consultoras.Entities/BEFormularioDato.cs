using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEFormularioDato
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public ETipoFormulario TipoFormularioID { get; set; }

        [DataMember]
        public int FormularioDatoID { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string Archivo { get; set; }

        [DataMember]
        public string URL { get; set; }

        public BEFormularioDato() { }
        public BEFormularioDato(IDataRecord row)
        {
            PaisID = Convert.ToInt32(row["PaisID"]);
            TipoFormularioID = (ETipoFormulario)Convert.ToInt32(row["TipoFormularioID"]);
            FormularioDatoID = Convert.ToInt32(row["FormularioDatoID"]);
            Descripcion = (string)row["Descripcion"];
            Archivo = (string)row["Archivo"];
            URL = (string)row["URL"];
        }
    }
}
