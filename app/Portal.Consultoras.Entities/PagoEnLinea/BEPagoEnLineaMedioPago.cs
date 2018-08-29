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
    public class BEPagoEnLineaMedioPago
    {
        [DataMember]
        public int PagoEnLineaMedioPagoId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string RutaIcono { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string TextoToolTip { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEPagoEnLineaMedioPago(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PagoEnLineaMedioPagoId"))
                PagoEnLineaMedioPagoId = Convert.ToInt32(datarec["PagoEnLineaMedioPagoId"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "Codigo"))
                Codigo = Convert.ToString(datarec["Codigo"]);
            if (DataRecord.HasColumn(datarec, "RutaIcono"))
                RutaIcono = Convert.ToString(datarec["RutaIcono"]);
            if (DataRecord.HasColumn(datarec, "Orden"))
                Orden = Convert.ToInt32(datarec["Orden"]);
            if (DataRecord.HasColumn(datarec, "TextoToolTip"))
                TextoToolTip = Convert.ToString(datarec["TextoToolTip"]);
            if (DataRecord.HasColumn(datarec, "Estado"))
                Estado = Convert.ToBoolean(datarec["Estado"]);
        }
    }
}
