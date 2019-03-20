using System.Runtime.Serialization;
using System.Collections.Generic;
namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [DataContract]
    public class MisLogrosCaminoBrillanteModel
    {
        [DataMember]
        public string Titulo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public List<Indicador> Indicador { get; set; }
    }
}