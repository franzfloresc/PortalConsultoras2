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
    public class BEPagoEnLineaTipoPasarela
    {
        [DataMember]
        public int PagoEnLineaTipoPasarelaId { get; set; }
        [DataMember]
        public string CodigoPlataforma { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BEPagoEnLineaTipoPasarela(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PagoEnLineaTipoPasarelaId"))
                PagoEnLineaTipoPasarelaId = Convert.ToInt32(datarec["PagoEnLineaTipoPasarelaId"]);
            if (DataRecord.HasColumn(datarec, "CodigoPlataforma"))
                CodigoPlataforma = Convert.ToString(datarec["CodigoPlataforma"]);
            if (DataRecord.HasColumn(datarec, "Codigo"))
                Codigo = Convert.ToString(datarec["Codigo"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "Valor"))
                Valor = Convert.ToString(datarec["Valor"]);
        }
    }
}
