using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);

            if (DataRecord.HasColumn(row, "DescripcionOperacion"))
                DescripcionOperacion = Convert.ToString(row["DescripcionOperacion"]);

            if (DataRecord.HasColumn(row, "MontoOperacion"))
                MontoOperacion = Convert.ToDecimal(row["MontoOperacion"]);

            if (DataRecord.HasColumn(row, "Cargo"))
                Cargo = Convert.ToDecimal(row["Cargo"]);

            if (DataRecord.HasColumn(row, "Abono"))
                Abono = Convert.ToDecimal(row["Abono"]);

            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);
        }

    }
}
