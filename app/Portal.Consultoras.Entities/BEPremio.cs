using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPremio
    {
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string CodigoConcurso { get; set; }
        [DataMember]
        public int PuntajeMinimo { get; set; }
        [DataMember]
        public int NumeroNivel { get; set; }
        [DataMember]
        public int Importante { get; set; }

        public BEPremio()
        { }

        public BEPremio(IDataRecord row)
        {
            Codigo = row.ToString("COD_PREM");
            Descripcion = row.ToString("DES_PROD");
            CodigoConcurso = row.ToString("COD_CONC");
            PuntajeMinimo = row.ToInt32("PUN_MINI");
            NumeroNivel = row.ToInt32("NUM_NIVE");
        }
    }
}
