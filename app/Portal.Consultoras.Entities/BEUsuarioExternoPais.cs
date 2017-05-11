using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioExternoPais
    {
        [DataMember]
        public string Proveedor { get; set; }

        [DataMember]
        public string IdAplicacion { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string CodigoISO { get; set; }

        public BEUsuarioExternoPais()
        {

        }

        public BEUsuarioExternoPais(IDataRecord row)
        {
            Proveedor = Convert.ToString(row["Proveedor"]);
            IdAplicacion = Convert.ToString(row["IdAplicacion"]);
            PaisID = Convert.ToInt16(row["PaisID"]);
            CodigoISO = Convert.ToString(row["CodigoISO"]);
        }

    }
}
