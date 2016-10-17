using System;
using System.Collections.Generic;
using System.Data; //R2073
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

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
            CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
           if(!Convert.IsDBNull(row["FechaRegistro"])) FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]); //R2524 - JICM - Validacion Fechas nulas
            DescripcionOperacion = Convert.ToString(row["DescripcionOperacion"]);
            MontoOperacion = Convert.ToDecimal(row["MontoOperacion"]);
            Cargo = Convert.ToDecimal(row["Cargo"]);
            Abono = Convert.ToDecimal(row["Abono"]);
            Orden = Convert.ToInt32(row["Orden"]);
        }
        // R2073 - Fin
    }
}
