using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Search.RequestRecomendacion.Estructura
{
    [DataContract]
    public class ProductoSolicitado
    {
        [DataMember]
        public string CodigoSap { get; set; }

        [DataMember]
        public int Cantidad { get; set; }
    }
}
