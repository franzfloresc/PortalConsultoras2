using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CargaMasiva
{
    [DataContract]
    public class BECargaMasivaImagenes
    {
        [DataMember]
        public string Cuv { get; set; }
        [DataMember]
        public string RutaImagen { get; set; }

        public BECargaMasivaImagenes(IDataRecord row)
        {
            Cuv = row.ToString("Cuv");
            RutaImagen = row.ToString("RutaImagen");
        }
    }
}
