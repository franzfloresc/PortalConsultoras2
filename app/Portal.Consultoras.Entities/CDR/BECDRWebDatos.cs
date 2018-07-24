using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            CDRWebDatosID = row.ToInt32("CDRWebDatosID");
            Codigo = row.ToString("Codigo");
            Valor = row.ToString("Valor");
        }
    }
}
