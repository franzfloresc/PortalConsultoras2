using System;
using System.Collections.Generic;
using System.Data; //R2073
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstadoCuenta
    {
        [DataMember]
        public DateTime Fecha { get; set; }

        [DataMember]
        public string Movimiento { get; set; }

        [DataMember]
        public decimal Pedido { get; set; }

        [DataMember]
        public decimal Abono { get; set; }

        // R2073 - Inicio
        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public string DescripcionOperacion { get; set; }

        [DataMember]
        public decimal MontoOperacion { get; set; }

        [DataMember]
        public decimal Cargo { get; set; }
        
		[DataMember]
        public int Orden { get; set; }

        [DataMember]
        public int TipoOperacion { get; set; }

        public BEEstadoCuenta()
        { }

        public BEEstadoCuenta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);

            if (DataRecord.HasColumn(row, "DescripcionOperacion") && row["DescripcionOperacion"] != DBNull.Value)
                DescripcionOperacion = Convert.ToString(row["DescripcionOperacion"]);

            if (DataRecord.HasColumn(row, "MontoOperacion") && row["MontoOperacion"] != DBNull.Value)
                MontoOperacion = Convert.ToDecimal(row["MontoOperacion"]);

            if (DataRecord.HasColumn(row, "Cargo") && row["Cargo"] != DBNull.Value)
                Cargo = Convert.ToDecimal(row["Cargo"]);

            if (DataRecord.HasColumn(row, "Abono") && row["Abono"] != DBNull.Value)
                Abono = Convert.ToDecimal(row["Abono"]);

            if (DataRecord.HasColumn(row, "Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);
        }
        // R2073 - Fin
    }
}
