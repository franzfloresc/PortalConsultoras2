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
            CodigoConsultora = row.ToString("CodigoConsultora");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            DescripcionOperacion = row.ToString("DescripcionOperacion");
            MontoOperacion = row.ToDecimal("MontoOperacion");
            Cargo = row.ToDecimal("Cargo");
            Abono = row.ToDecimal("Abono");
            Orden = row.ToInt32("Orden");
        }

    }
}
