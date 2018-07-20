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
    public class BEPagoEnLineaMedioPagoDetalle
    {
        [DataMember]
        public int PagoEnLineaMedioPagoDetalleId { get; set; }
        [DataMember]
        public int PagoEnLineaMedioPagoId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string TipoVisualizacionTyC { get; set; }
        [DataMember]
        public string TerminosCondiciones { get; set; }
        [DataMember]
        public string TipoPasarelaCodigoPlataforma { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        #region Variables Externas

        [DataMember]
        public string RutaIcono { get; set; }

        #endregion        

        public BEPagoEnLineaMedioPagoDetalle(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PagoEnLineaMedioPagoDetalleId"))
                PagoEnLineaMedioPagoDetalleId = Convert.ToInt32(datarec["PagoEnLineaMedioPagoDetalleId"]);
            if (DataRecord.HasColumn(datarec, "PagoEnLineaMedioPagoId"))
                PagoEnLineaMedioPagoId = Convert.ToInt32(datarec["PagoEnLineaMedioPagoId"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "Orden"))
                Orden = Convert.ToInt32(datarec["Orden"]);
            if (DataRecord.HasColumn(datarec, "TipoVisualizacionTyC"))
                TipoVisualizacionTyC = Convert.ToString(datarec["TipoVisualizacionTyC"]);
            if (DataRecord.HasColumn(datarec, "TerminosCondiciones"))
                TerminosCondiciones = Convert.ToString(datarec["TerminosCondiciones"]);
            if (DataRecord.HasColumn(datarec, "TipoPasarelaCodigoPlataforma"))
                TipoPasarelaCodigoPlataforma = Convert.ToString(datarec["TipoPasarelaCodigoPlataforma"]);
            if (DataRecord.HasColumn(datarec, "Estado"))
                Estado = Convert.ToBoolean(datarec["Estado"]);

            if (DataRecord.HasColumn(datarec, "RutaIcono"))
                RutaIcono = Convert.ToString(datarec["RutaIcono"]);
        }
    }
}
