using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogoIssuu
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string CodigoIssuu { get; set; }
        [DataMember]
        public string UrlVisor { get; set; }
    }
}
