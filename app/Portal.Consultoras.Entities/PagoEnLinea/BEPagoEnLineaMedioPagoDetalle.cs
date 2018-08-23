using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
        public string ExpresionRegularTarjeta { get; set; }
        [DataMember]
        public string TipoTarjeta { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        #region Variables Externas

        [DataMember]
        public string RutaIcono { get; set; }

        #endregion        

        public BEPagoEnLineaMedioPagoDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "PagoEnLineaMedioPagoDetalleId"))
                PagoEnLineaMedioPagoDetalleId = Convert.ToInt32(row["PagoEnLineaMedioPagoDetalleId"]);
            if (DataRecord.HasColumn(row, "PagoEnLineaMedioPagoId"))
                PagoEnLineaMedioPagoId = Convert.ToInt32(row["PagoEnLineaMedioPagoId"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "TipoVisualizacionTyC"))
                TipoVisualizacionTyC = Convert.ToString(row["TipoVisualizacionTyC"]);
            if (DataRecord.HasColumn(row, "TerminosCondiciones"))
                TerminosCondiciones = Convert.ToString(row["TerminosCondiciones"]);
            if (DataRecord.HasColumn(row, "TipoPasarelaCodigoPlataforma"))
                TipoPasarelaCodigoPlataforma = Convert.ToString(row["TipoPasarelaCodigoPlataforma"]);

            ExpresionRegularTarjeta = row.ToString("ExpresionRegularTarjeta");
            TipoTarjeta = row.ToString("TipoTarjeta");
            Estado = row.ToBoolean("Estado");
            RutaIcono = row.ToString("RutaIcono");
        }
    }
}
