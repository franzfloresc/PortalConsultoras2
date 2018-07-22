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
            PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            ConsultoraCodigo = Convert.ToString(row["ConsultoraCodigo"]);
            ConsultoraNombre = Convert.ToString(row["ConsultoraNombre"]);
            ConsultoraCorreo = Convert.ToString(row["ConsultoraCorreo"]);
            ConsultoraCelular = Convert.ToString(row["ConsultoraCelular"]);
            Campania = row.ToString("Campania");
            Leido = row.ToInt16("Leido");
            MarcaID = Convert.ToInt32(row["MarcaID"]);
            Marca = Convert.ToString(row["Marca"]);
            TipoUsuario = row.ToInt32("TipoUsuario");
            FlagConsultora = row.ToBoolean("FlagConsultora");
            FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            Estado = Convert.ToString(row["Estado"]);
            ClienteNombre = Convert.ToString(row["ClienteNombre"]);
            ClienteTelefono = Convert.ToString(row["ClienteTelefono"]);
            ClienteEmail = Convert.ToString(row["ClienteEmail"]);
            ClienteDireccion = Convert.ToString(row["ClienteDireccion"]);
            Mensaje = Convert.ToString(row["Mensaje"]);
            Total = row.ToDecimal("Total");
            Cantidad = Convert.ToInt32(row["Cantidad"]);
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
            PedidoDetalleId = Convert.ToInt64(row["SolicitudClienteDetalleID"]);
            PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            Producto = Convert.ToString(row["Producto"]);
            Tono = Convert.ToString(row["Tono"]);
            Marca = Convert.ToString(row["Marca"]);
            CUV = Convert.ToString(row["CUV"]);
            PrecioUnitario = Convert.ToDouble(row["Precio"]);
            Cantidad = Convert.ToInt32(row["Cantidad"]);
            SubTotal = PrecioUnitario * Cantidad;
            Url = Convert.ToString(row["Url"]);
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
