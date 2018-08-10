using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMisPedidosAppCatalogo
    {
        [DataMember]
        public long PedidoId { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public string ConsultoraCodigo { get; set; }
        [DataMember]
        public string ConsultoraNombre { get; set; }
        [DataMember]
        public string ConsultoraCorreo { get; set; }
        [DataMember]
        public string ConsultoraCelular { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public int Leido { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string Marca { get; set; }
        [DataMember]
        public int TipoUsuario { get; set; }
        [DataMember]
        public bool FlagConsultora { get; set; }
        [DataMember]
        public DateTime FechaSolicitud { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public string ClienteNombre { get; set; }
        [DataMember]
        public string ClienteTelefono { get; set; }
        [DataMember]
        public string ClienteEmail { get; set; }
        [DataMember]
        public string ClienteDireccion { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public decimal Total { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public List<BEMisPedidosDetalleAppCatalogo> DetallePedido { get; set; }

        public BEMisPedidosAppCatalogo(IDataRecord row)
        {
            PedidoId = row.ToInt64("SolicitudClienteID");
            ConsultoraID = row.ToInt32("ConsultoraID");
            ConsultoraCodigo = row.ToString("ConsultoraCodigo");
            ConsultoraNombre = row.ToString("ConsultoraNombre");
            ConsultoraCorreo = row.ToString("ConsultoraCorreo");
            ConsultoraCelular = row.ToString("ConsultoraCelular");
            Campania = row.ToString("Campania");
            Leido = row.ToInt16("Leido");
            MarcaID = row.ToInt32("MarcaID");
            Marca = row.ToString("Marca");
            TipoUsuario = row.ToInt32("TipoUsuario");
            FlagConsultora = row.ToBoolean("FlagConsultora");
            FechaSolicitud = row.ToDateTime("FechaSolicitud");
            Estado = row.ToString("Estado");
            ClienteNombre = row.ToString("ClienteNombre");
            ClienteTelefono = row.ToString("ClienteTelefono");
            ClienteEmail = row.ToString("ClienteEmail");
            ClienteDireccion = row.ToString("ClienteDireccion");
            Mensaje = row.ToString("Mensaje");
            Total = row.ToDecimal("Total");
            Cantidad = row.ToInt32("Cantidad");
            DetallePedido = new List<BEMisPedidosDetalleAppCatalogo>();
        }
    }

    [DataContract]
    public class BEResultadoMisPedidosAppCatalogo
    {
        [DataMember]
        [ViewProperty]
        public Boolean Error { get; set; }
        [DataMember]
        [ViewProperty]
        public string Mensaje { get; set; }
        [DataMember]
        [ViewProperty]
        public List<BEMisPedidosAppCatalogo> Data { get; set; }

        public BEResultadoMisPedidosAppCatalogo(IDataRecord row)
        {

                Error = row.ToBoolean("Error");

                Mensaje = row.ToString("Mensaje");
        }

        public BEResultadoMisPedidosAppCatalogo(Boolean error, string mensaje)
        {
            Error = error;
            Mensaje = mensaje;
        }
    }

    [DataContract]
    public class BEMisPedidosDetalleAppCatalogo
    {
        [DataMember]
        public long PedidoDetalleId { get; set; }
        [DataMember]
        public long PedidoId { get; set; }
        [DataMember]
        public string Producto { get; set; }
        [DataMember]
        public string Tono { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string Marca { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Url { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public double PrecioUnitario { get; set; }
        [DataMember]
        public double SubTotal { get; set; }

        public BEMisPedidosDetalleAppCatalogo() { }

        public BEMisPedidosDetalleAppCatalogo(IDataRecord row)
        {
            PedidoDetalleId = row.ToInt64("SolicitudClienteDetalleID");
            PedidoId = row.ToInt64("SolicitudClienteID");
            Producto = row.ToString("Producto");
            Tono = row.ToString("Tono");
            Marca = row.ToString("Marca");
            CUV = row.ToString("CUV");
            PrecioUnitario = row.ToDouble("Precio");
            Cantidad = row.ToInt32("Cantidad");
            SubTotal = PrecioUnitario * Cantidad;
            Url = row.ToString("Url");
        }
    }

    [DataContract]
    public class BEResultadoPedidoDetalleAppCatalogo
    {
        [DataMember]
        [ViewProperty]
        public Boolean Error { get; set; }
        [DataMember]
        [ViewProperty]
        public string Mensaje { get; set; }
        [DataMember]
        [ViewProperty]
        public List<BEMisPedidosDetalleAppCatalogo> Data { get; set; }

        public BEResultadoPedidoDetalleAppCatalogo(IDataRecord row)
        {

                Error = row.ToBoolean("Error");

                Mensaje = row.ToString("Mensaje");
        }

        public BEResultadoPedidoDetalleAppCatalogo(Boolean error, string mensaje)
        {
            Error = error;
            Mensaje = mensaje;
        }
    }
}
