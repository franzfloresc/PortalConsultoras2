using Portal.Consultoras.Common;
using System;
using System.Data;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class EstadoCuentaModel
    {
        public string MontoPagar { set; get; }
        public string Simbolo { set; get; }
        public string FechaVencimiento { set; get; }
        public string CorreoConsultora { set; get; }

        public DateTime Fecha { get; set; }
        public string Glosa { get; set; }
        public decimal Cargo { get; set; }
        public decimal Abono { get; set; }
        public int TipoMovimiento { get; set; }
        public string FechaVencimientoFormatDiaMes { get; set; }

        public EstadoCuentaModel()
        {
        }
        public EstadoCuentaModel(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Fecha"))
                Fecha = Convert.ToDateTime(row["Fecha"]);
            if (DataRecord.HasColumn(row, "Glosa"))
                Glosa = Convert.ToString(row["Glosa"]);
            if (DataRecord.HasColumn(row, "Cargo"))
                Cargo = Convert.ToDecimal(row["Cargo"]);
            if (DataRecord.HasColumn(row, "Abono"))
                Abono = Convert.ToDecimal(row["Abono"]);
            if (DataRecord.HasColumn(row, "TipoMovimiento"))
                TipoMovimiento = Convert.ToInt16(row["TipoMovimiento"]);
        }
    }
}