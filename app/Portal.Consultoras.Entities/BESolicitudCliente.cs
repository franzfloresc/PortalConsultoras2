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
            if (DataRecord.HasColumn(row, "SolicitudClienteID"))
                SolicitudClienteID = Convert.ToInt64(row["SolicitudClienteID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                CodigoConsultora = Convert.ToString(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "Email"))
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "CodigoUbigeo"))
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            if (DataRecord.HasColumn(row, "Telefono"))
                Telefono = Convert.ToString(row["Telefono"]);
            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "MarcaNombre"))
                MarcaNombre = Convert.ToString(row["MarcaNombre"]);
            if (DataRecord.HasColumn(row, "Leido"))
                Leido = Convert.ToInt32(row["Leido"]);
            if (DataRecord.HasColumn(row, "MensajeaCliente"))
                MensajeaCliente = Convert.ToString(row["MensajeaCliente"]);
            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToString(row["Estado"]);
            if (DataRecord.HasColumn(row, "NumIteracion"))
                NumIteracion = Convert.ToInt32(row["NumIteracion"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "NombreGZ"))
                NombreGZ = Convert.ToString(row["NombreGZ"]);
            if (DataRecord.HasColumn(row, "EmailGZ"))
                EmailGZ = Convert.ToString(row["EmailGZ"]);
            if (DataRecord.HasColumn(row, "MensajeaGZ"))
                MensajeaGZ = Convert.ToString(row["MensajeaGZ"]);
            if (DataRecord.HasColumn(row, "UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "FechaSolicitud"))
                FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            if (DataRecord.HasColumn(row, "Seccion"))
                Seccion = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "NombreConsultoraAsignada"))
                NombreConsultoraAsignada = Convert.ToString(row["NombreConsultoraAsignada"]);
            if (DataRecord.HasColumn(row, "CorreoConsultoraAsginada"))
                CorreoConsultoraAsginada = Convert.ToString(row["CorreoConsultoraAsginada"]);

            if (DataRecord.HasColumn(row, "EnviadoGZ"))
                EnviadoGZ = Convert.ToString(row["EnviadoGZ"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica1"))
                UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica2"))
                UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica3"))
                UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);
            if (DataRecord.HasColumn(row, "TipoDistribucion"))
                TipoDistribucion = Convert.ToInt32(row["TipoDistribucion"]);

            if (DataRecord.HasColumn(row, "EstadoSolicitudClienteId"))
                EstadoSolicitudClienteId = Convert.ToInt32(row["EstadoSolicitudClienteId"]);

            if (DataRecord.HasColumn(row, "PedidoWebID"))
                PedidoWebID = Convert.ToInt32(row["PedidoWebID"]);
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
            if (DataRecord.HasColumn(row, "SolicitudClienteID"))
                SolicitudClienteID = Convert.ToInt64(row["SolicitudClienteID"]);
            if (DataRecord.HasColumn(row, "SolicitudClienteDetalleID"))
                SolicitudClienteDetalleID = Convert.ToInt64(row["SolicitudClienteDetalleID"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Producto"))
                DescripcionProducto = Convert.ToString(row["Producto"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "Precio"))
                Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "Tono"))
                Tono = Convert.ToString(row["Tono"]);
            if (DataRecord.HasColumn(row, "DescripcionMarca"))
                DescripcionMarca = Convert.ToString(row["DescripcionMarca"]);

            if (DataRecord.HasColumn(row, "TipoAtencion"))
                TipoAtencion = Convert.ToInt32(row["TipoAtencion"]);

            if (DataRecord.HasColumn(row, "PedidoWebID"))
                PedidoWebID = Convert.ToInt32(row["PedidoWebID"]);

            if (DataRecord.HasColumn(row, "PedidoWebDetalleID"))
                PedidoWebDetalleID = Convert.ToInt32(row["PedidoWebDetalleID"]);

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
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Producto"))
                DescripcionProducto = Convert.ToString(row["Producto"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "Precio"))
                Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "Tono"))
                Tono = Convert.ToString(row["Tono"]);
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
            if (DataRecord.HasColumn(row, "Resultado"))
                Resultado = Convert.ToInt32(row["Resultado"]);
            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);
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
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "EMail"))
                Email = Convert.ToString(row["EMail"]);
            if (DataRecord.HasColumn(row, "MarcaNombre"))
                MarcaNombre = Convert.ToString(row["MarcaNombre"]);
        }
    }
}
