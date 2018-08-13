using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BESolicitudCliente
    {
        [DataMember]
        public long SolicitudClienteID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string CodigoUbigeo { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string MarcaNombre { get; set; }
        [DataMember]
        public int Leido { get; set; }
        [DataMember]
        public string MensajeaCliente { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public int NumIteracion { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string NombreGZ { get; set; }
        [DataMember]
        public string EmailGZ { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string NombreConsultoraAsignada { get; set; }
        [DataMember]
        public string CorreoConsultoraAsginada { get; set; }
        [DataMember]
        public string MensajeaGZ { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public DateTime FechaSolicitud { get; set; }
        [DataMember]
        public IList<BESolicitudClienteDetalle> DetalleSolicitud { get; set; }
        [DataMember]
        public string EnviadoGZ { get; set; }
        [DataMember]
        public string UnidadGeografica1 { get; set; }
        [DataMember]
        public string UnidadGeografica2 { get; set; }
        [DataMember]
        public string UnidadGeografica3 { get; set; }
        [DataMember]
        public int TipoDistribucion { get; set; }
        [DataMember]
        public int EstadoSolicitudClienteId { get; set; }

        [DataMember]
        public int PedidoWebID { get; set; }

        public BESolicitudCliente()
        {
        }

        public BESolicitudCliente(IDataRecord row)
        {
            SolicitudClienteID = row.ToInt64("SolicitudClienteID");
            CodigoConsultora = row.ToString("ConsultoraID");
            NombreCompleto = row.ToString("NombreCompleto");
            Email = row.ToString("Email");
            CodigoUbigeo = row.ToString("CodigoUbigeo");
            Telefono = row.ToString("Telefono");
            Mensaje = row.ToString("Mensaje");
            Campania = row.ToString("Campania");
            MarcaID = row.ToInt32("MarcaID");
            MarcaNombre = row.ToString("MarcaNombre");
            Leido = row.ToInt32("Leido");
            MensajeaCliente = row.ToString("MensajeaCliente");
            Estado = row.ToString("Estado");
            NumIteracion = row.ToInt32("NumIteracion");
            Direccion = row.ToString("Direccion");
            NombreGZ = row.ToString("NombreGZ");
            EmailGZ = row.ToString("EmailGZ");
            MensajeaGZ = row.ToString("MensajeaGZ");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            FechaSolicitud = row.ToDateTime("FechaSolicitud");
            Seccion = row.ToString("Seccion");
            NombreConsultoraAsignada = row.ToString("NombreConsultoraAsignada");
            CorreoConsultoraAsginada = row.ToString("CorreoConsultoraAsginada");
            EnviadoGZ = row.ToString("EnviadoGZ");
            UnidadGeografica1 = row.ToString("UnidadGeografica1");
            UnidadGeografica2 = row.ToString("UnidadGeografica2");
            UnidadGeografica3 = row.ToString("UnidadGeografica3");
            TipoDistribucion = row.ToInt32("TipoDistribucion");
            EstadoSolicitudClienteId = row.ToInt32("EstadoSolicitudClienteId");
            PedidoWebID = row.ToInt32("PedidoWebID");
        }

    }

    [DataContract]
    public class BESolicitudClienteDetalle
    {
        [DataMember]
        public long SolicitudClienteID { get; set; }
        [DataMember]
        public long SolicitudClienteDetalleID { get; set; }

        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionProducto { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal Precio { get; set; }
        [DataMember]
        public string Tono { get; set; }
        [DataMember]
        public string DescripcionMarca { get; set; }

        [DataMember]
        public int TipoAtencion { get; set; }

        [DataMember]
        public int PedidoWebID { get; set; }

        [DataMember]
        public int PedidoWebDetalleID { get; set; }

        public BESolicitudClienteDetalle() { }

        public BESolicitudClienteDetalle(IDataRecord row)
        {
            
                SolicitudClienteID = row.ToInt64("SolicitudClienteID");
            
                SolicitudClienteDetalleID = row.ToInt64("SolicitudClienteDetalleID");

            
                CUV = row.ToString("CUV");
            
                DescripcionProducto = row.ToString("Producto");
            
                Cantidad = row.ToInt32("Cantidad");
            
                Precio = row.ToDecimal("Precio");
            
                Tono = row.ToString("Tono");
            
                DescripcionMarca = row.ToString("DescripcionMarca");

            
                TipoAtencion = row.ToInt32("TipoAtencion");

            
                PedidoWebID = row.ToInt32("PedidoWebID");

            
                PedidoWebDetalleID = row.ToInt32("PedidoWebDetalleID");

        }
    }

    [DataContract]
    public class BESolicitudClienteDetalleStoreParameter
    {

        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionProducto { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal Precio { get; set; }
        [DataMember]
        public string Tono { get; set; }
        public BESolicitudClienteDetalleStoreParameter() { }
        public BESolicitudClienteDetalleStoreParameter(BESolicitudClienteDetalle solicitudClienteDetalle)
        {

            CUV = solicitudClienteDetalle.CUV;
            DescripcionProducto = solicitudClienteDetalle.DescripcionProducto;
            Cantidad = solicitudClienteDetalle.Cantidad;
            Precio = solicitudClienteDetalle.Precio;
            Tono = solicitudClienteDetalle.Tono;
        }

        public BESolicitudClienteDetalleStoreParameter(IDataRecord row)
        {
            
                CUV = row.ToString("CUV");
            
                DescripcionProducto = row.ToString("Producto");
            
                Cantidad = row.ToInt32("Cantidad");
            
                Precio = row.ToDecimal("Precio");
            
                Tono = row.ToString("Tono");
        }
    }

    [DataContract]
    public class BEEntradaSolicitudCliente
    {
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string CodigoUbigeo { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public IList<BESolicitudClienteDetalle> DetalleSolicitud { get; set; }

        public BEEntradaSolicitudCliente()
        {
        }
    }

    [DataContract]
    public class BEResultadoSolicitud
    {
        [DataMember]
        [ViewProperty]
        public int Resultado { get; set; }
        [DataMember]
        [ViewProperty]
        public string Mensaje { get; set; }

        public BEResultadoSolicitud(IDataRecord row)
        {
            
                Resultado = row.ToInt32("Resultado");
            
                Mensaje = row.ToString("Mensaje");
        }

        public BEResultadoSolicitud(int resultado, string mensaje)
        {
            Resultado = resultado;
            Mensaje = mensaje;
        }

    }

    [DataContract]
    public class BESolicitudNuevaConsultora
    {
        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string MarcaNombre { get; set; }

        public BESolicitudNuevaConsultora(IDataRecord row)
        {
            
                Nombre = row.ToString("Nombre");
            
                Email = row.ToString("EMail");
            
                MarcaNombre = row.ToString("MarcaNombre");
        }
    }
}
