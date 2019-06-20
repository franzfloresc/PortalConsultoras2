using Portal.Consultoras.Common;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBeneficiosCaminoBrillante
    {
        [DataMember]
        public string CodigoNivel { get; set; }

        [DataMember]
        public string CodigoBeneficio { get; set; }

        [DataMember]
        public string NombreBeneficio { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string UrlIcono { get; set; }

        public BEBeneficiosCaminoBrillante(IDataRecord row)
        {
            CodigoNivel = row.ToString("CodigoNivel");
            CodigoBeneficio = row.ToString("CodigoBeneficio");
            NombreBeneficio = row.ToString("NombreBeneficio");
            Descripcion = row.ToString("Descripcion");
            UrlIcono = row.ToString("UrlIcono");
        }
    }
}
