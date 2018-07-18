using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            CodigoConsultora = row.ToString("CodigoConsultora");
            NombreCompleto = row.ToString("NombreCompleto");
            Direccion = row.ToString("Direccion");
            Email = row.ToString("Email");
            Telefono = row.ToString("Telefono");
            Territorio = row.ToString("Territorio");
            EstadoActividad = row.ToString("EstadoActividad");
            MontoSaldoActual = row.ToDecimal("MontoSaldoActual");
            AutorizaPedido = row.ToString("AutorizaPedido");
            NroDocumentoConsultora = row.ToString("NroDocumentoConsultora");
        }
    }
}
