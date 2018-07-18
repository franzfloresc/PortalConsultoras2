using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEReportePedidos
    {
        [DataMember]
        private int SolicitudClienteID { get; set; }
        [DataMember]
        private string Estado { get; set; }
        [DataMember]
        private DateTime FechaSolicitud { get; set; }
        [DataMember]
        private string NombreCliente { get; set; }
        [DataMember]
        private string Direccion { get; set; }
        [DataMember]
        private string EmailCliente { get; set; }
        [DataMember]
        private string TelefonoCliente { get; set; }
        [DataMember]
        private string Marca { get; set; }
        [DataMember]
        private string Campania { get; set; }
        [DataMember]
        private string Producto { get; set; }
        [DataMember]
        private string Tono { get; set; }
        [DataMember]
        private int Cantidad { get; set; }
        [DataMember]
        private decimal Precio { get; set; }
        [DataMember]
        private string MensajeCliente { get; set; }
        [DataMember]
        private string CodigoConsultora { get; set; }
        [DataMember]
        private string NombreConsultora { get; set; }
        [DataMember]
        private string TelefonoMovilConsultora { get; set; }
        [DataMember]
        private string TelefonoFijoConsultora { get; set; }
        [DataMember]
        private string EmailConsultora { get; set; }
        [DataMember]
        private bool Leido { get; set; }


        public BEReportePedidos(IDataRecord row)
        {
            SolicitudClienteID = row.ToInt32("SolicitudClienteID");
            Estado = row.ToString("Estado");
            FechaSolicitud = row.ToDateTime("FechaSolicitud");
            NombreCliente = row.ToString("NombreCliente");
            Direccion = row.ToString("Direccion");
            EmailCliente = row.ToString("EmailCliente");
            TelefonoCliente = row.ToString("TelefonoCliente");
            Marca = row.ToString("Marca");
            Campania = row.ToString("Campania");
            Producto = row.ToString("Producto");
            Tono = row.ToString("Tono");
            Cantidad = row.ToInt16("Cantidad");
            Precio = row.ToDecimal("Precio");
            MensajeCliente = row.ToString("MensajeCliente");
            CodigoConsultora = row.ToString("CodigoConsultora");
            NombreConsultora = row.ToString("NombreConsultora");
            TelefonoMovilConsultora = row.ToString("TelefonoMovilConsultora");
            TelefonoFijoConsultora = row.ToString("TelefonoFijoConsultora");
            EmailConsultora = row.ToString("EmailConsultora");
            Leido = row.ToBoolean("Leido");
        }
    }
}
