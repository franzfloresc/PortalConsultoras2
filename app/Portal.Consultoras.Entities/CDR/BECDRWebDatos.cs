using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWebDatos
    {
        [DataMember]
        public int CDRWebDatosID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BECDRWebDatos()
        { }

        public BECDRWebDatos(IDataRecord row)
        {
            if (row.HasColumn("CDRWebDatosID")) CDRWebDatosID = Convert.ToInt32(row["CDRWebDatosID"]);
            if (row.HasColumn("Codigo")) Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Valor")) Valor = Convert.ToString(row["Valor"]);
        }
    }
}
