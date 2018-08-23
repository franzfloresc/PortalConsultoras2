using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaTipoPago
    {
        [DataMember]
        public int PagoEnLineaTipoPagoId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEPagoEnLineaTipoPago(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PagoEnLineaTipoPagoId"))
                PagoEnLineaTipoPagoId = Convert.ToInt32(datarec["PagoEnLineaTipoPagoId"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "Codigo"))
                Codigo = Convert.ToString(datarec["Codigo"]);
            if (DataRecord.HasColumn(datarec, "Estado"))
                Estado = Convert.ToBoolean(datarec["Estado"]);
        }
    }
}
