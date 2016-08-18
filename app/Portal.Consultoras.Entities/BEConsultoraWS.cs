using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraWS
    {
        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string NombreCompleto { get; set; }

        [DataMember]
        public string Direccion { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string Telefono { get; set; }

        [DataMember]
        public string Territorio { get; set; }

        [DataMember]
        public string EstadoActividad { get; set; }

        [DataMember]
        public decimal MontoSaldoActual { get; set; }

        [DataMember]
        public string AutorizaPedido { get; set; }

        [DataMember]
        public string NroDocumentoConsultora { get; set; }

        public BEConsultoraWS()
        { 
        
        }

        public BEConsultoraWS(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "Email"))
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "Telefono"))
                Telefono = Convert.ToString(row["Telefono"]);
            if (DataRecord.HasColumn(row, "Territorio"))
                Territorio = Convert.ToString(row["Territorio"]);
            if (DataRecord.HasColumn(row, "EstadoActividad"))
                EstadoActividad = Convert.ToString(row["EstadoActividad"]);
            if (DataRecord.HasColumn(row, "MontoSaldoActual"))
                MontoSaldoActual = Convert.ToDecimal(row["MontoSaldoActual"]);
            if (DataRecord.HasColumn(row, "AutorizaPedido"))
                AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);
            if (DataRecord.HasColumn(row, "NroDocumentoConsultora"))
                NroDocumentoConsultora = Convert.ToString(row["NroDocumentoConsultora"]);
        }
    }
}
