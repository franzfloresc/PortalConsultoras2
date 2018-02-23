using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ClienteOnlineModel
    {
        public ClienteOnlineModel()
        {
            this.Detalles = new List<ClienteOnlineDetalleModel>();
            this.MotivosRechazo = new List<MisPedidosMotivoRechazoModel>();
            this.EstadoDesc = "";
            this.Cliente = "";
            this.MensajeDelCliente = "";
        }

        public long SolicitudClienteID { get; set; }
        public int MarcaID { get; set; }
        public bool ClienteNuevo { get; set; }
        public string TipoCliente { get; set; }
        public string Cliente { get; set; }
        public string Marca { get; set; }
        public string Origen { get; set; }
        public string Campania { get; set; }
        public DateTime FechaSolicitud { get; set; }
        public string FechaSolicitudString { get; set; }
        public decimal PrecioTotal { get; set; }
        public string PrecioTotalString { get; set; }
        public string Estado { get; set; }
        public string EstadoDesc { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
        public string Email { get; set; }
        public string MensajeDelCliente { get; set; }
        public bool PuedeCancelar { get; set; }
        public List<ClienteOnlineDetalleModel> Detalles { get; set; }
        public List<MisPedidosMotivoRechazoModel> MotivosRechazo { get; set; }
    }
}