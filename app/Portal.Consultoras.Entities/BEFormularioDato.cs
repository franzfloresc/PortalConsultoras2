using Portal.Consultoras.Common;
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
            PaisID = row.ToInt32("PaisID");
            TipoFormularioID = (ETipoFormulario)row.ToInt32("TipoFormularioID");
            FormularioDatoID = row.ToInt32("FormularioDatoID");
            Descripcion = row.ToString("Descripcion");
            Archivo = row.ToString("Archivo");
            URL = row.ToString("URL");
        }
    }
}
