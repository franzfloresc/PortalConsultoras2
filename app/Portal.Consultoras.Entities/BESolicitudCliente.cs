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
            if (DataRecord.HasColumn(row, "SolicitudClienteID") && row["SolicitudClienteID"] != DBNull.Value)
                SolicitudClienteID = Convert.ToInt64(row["SolicitudClienteID"].ToString());
            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "Email") && row["Email"] != DBNull.Value)
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "CodigoUbigeo") && row["CodigoUbigeo"] != DBNull.Value)
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            if (DataRecord.HasColumn(row, "Telefono") && row["Telefono"] != DBNull.Value)
                Telefono = Convert.ToString(row["Telefono"]);
            if (DataRecord.HasColumn(row, "Mensaje") && row["Mensaje"] != DBNull.Value)
                Mensaje = Convert.ToString(row["Mensaje"]);
            if (DataRecord.HasColumn(row, "Campania") && row["Campania"] != DBNull.Value)
                Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "MarcaID") && row["MarcaID"] != DBNull.Value)
                MarcaID = Convert.ToInt32(row["MarcaID"].ToString());
            if (DataRecord.HasColumn(row, "MarcaNombre") && row["MarcaNombre"] != DBNull.Value)
                MarcaNombre = Convert.ToString(row["MarcaNombre"].ToString());
            if (DataRecord.HasColumn(row, "Leido") && row["Leido"] != DBNull.Value)
                Leido = Convert.ToInt32(row["Leido"]);
            if (DataRecord.HasColumn(row, "MensajeaCliente") && row["MensajeaCliente"] != DBNull.Value)
                MensajeaCliente = Convert.ToString(row["MensajeaCliente"]);
            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToString(row["Estado"]);
            if (DataRecord.HasColumn(row, "NumIteracion") && row["NumIteracion"] != DBNull.Value)
                NumIteracion = Convert.ToInt32(row["NumIteracion"].ToString());
            if (DataRecord.HasColumn(row, "Direccion") && row["Direccion"] != DBNull.Value)
                Direccion = Convert.ToString(row["Direccion"].ToString());
            if (DataRecord.HasColumn(row, "NombreGZ") && row["NombreGZ"] != DBNull.Value)
                NombreGZ = Convert.ToString(row["NombreGZ"]);
            if (DataRecord.HasColumn(row, "EmailGZ") && row["EmailGZ"] != DBNull.Value)
                EmailGZ = Convert.ToString(row["EmailGZ"]);
            if (DataRecord.HasColumn(row, "MensajeaGZ") && row["MensajeaGZ"] != DBNull.Value)
                MensajeaGZ = Convert.ToString(row["MensajeaGZ"]);
            if (DataRecord.HasColumn(row, "UsuarioModificacion") && row["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "FechaSolicitud") && row["FechaSolicitud"] != DBNull.Value)
                FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            if (DataRecord.HasColumn(row, "Seccion") && row["Seccion"] != DBNull.Value)
                Seccion = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "NombreConsultoraAsignada") && row["NombreConsultoraAsignada"] != DBNull.Value)
                NombreConsultoraAsignada = Convert.ToString(row["NombreConsultoraAsignada"]);
            if (DataRecord.HasColumn(row, "CorreoConsultoraAsginada") && row["CorreoConsultoraAsginada"] != DBNull.Value)
                CorreoConsultoraAsginada = Convert.ToString(row["CorreoConsultoraAsginada"]);

            if (DataRecord.HasColumn(row, "EnviadoGZ") && row["EnviadoGZ"] != DBNull.Value)
                EnviadoGZ = Convert.ToString(row["EnviadoGZ"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica1") && row["UnidadGeografica1"] != DBNull.Value)
                UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica2") && row["UnidadGeografica2"] != DBNull.Value)
                UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica3") && row["UnidadGeografica3"] != DBNull.Value)
                UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);
            if (DataRecord.HasColumn(row, "TipoDistribucion") && row["TipoDistribucion"] != DBNull.Value)
                TipoDistribucion = Convert.ToInt32(row["TipoDistribucion"]);

            if (DataRecord.HasColumn(row, "EstadoSolicitudClienteId") && row["EstadoSolicitudClienteId"] != DBNull.Value)
                EstadoSolicitudClienteId = Convert.ToInt32(row["EstadoSolicitudClienteId"]);

            if (DataRecord.HasColumn(row, "PedidoWebID") && row["PedidoWebID"] != DBNull.Value)
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
            if (DataRecord.HasColumn(row, "SolicitudClienteID") && row["SolicitudClienteID"] != DBNull.Value)
                SolicitudClienteID = Convert.ToInt64(row["SolicitudClienteID"]);
            if (DataRecord.HasColumn(row, "SolicitudClienteDetalleID") && row["SolicitudClienteDetalleID"] != DBNull.Value)
                SolicitudClienteDetalleID = Convert.ToInt64(row["SolicitudClienteDetalleID"]);

            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Producto") && row["Producto"] != DBNull.Value)
                DescripcionProducto = Convert.ToString(row["Producto"]);
            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                Cantidad = Convert.ToInt32(row["Cantidad"].ToString());
            if (DataRecord.HasColumn(row, "Precio") && row["Precio"] != DBNull.Value)
                Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "Tono"))
                Tono = Convert.ToString(row["Tono"]);
            if (DataRecord.HasColumn(row, "DescripcionMarca") && row["DescripcionMarca"] != DBNull.Value)
                DescripcionMarca = Convert.ToString(row["DescripcionMarca"]);

            if (DataRecord.HasColumn(row, "TipoAtencion") && row["TipoAtencion"] != DBNull.Value)
                TipoAtencion = Convert.ToInt32(row["TipoAtencion"]);

            if (DataRecord.HasColumn(row, "PedidoWebID") && row["PedidoWebID"] != DBNull.Value)
                PedidoWebID = Convert.ToInt32(row["PedidoWebID"]);

            if (DataRecord.HasColumn(row, "PedidoWebDetalleID") && row["PedidoWebDetalleID"] != DBNull.Value)
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
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Producto") && row["Producto"] != DBNull.Value)
                DescripcionProducto = Convert.ToString(row["Producto"]);
            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                Cantidad = Convert.ToInt32(row["Cantidad"].ToString());
            if (DataRecord.HasColumn(row, "Precio") && row["Precio"] != DBNull.Value)
                Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "Tono") && row["Tono"] != DBNull.Value)
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
            if (DataRecord.HasColumn(row, "Resultado") && row["Resultado"] != DBNull.Value)
                Resultado = Convert.ToInt32(row["Resultado"].ToString());
            if (DataRecord.HasColumn(row, "Mensaje") && row["Mensaje"] != DBNull.Value)
                Mensaje = Convert.ToString(row["Mensaje"]);
        }

        public BEResultadoSolicitud(int resultado, string mensaje)
        {
            this.Resultado = resultado;
            this.Mensaje = mensaje;
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
            if (DataRecord.HasColumn(row, "Nombre") && row["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(row["Nombre"].ToString());
            if (DataRecord.HasColumn(row, "EMail") && row["EMail"] != DBNull.Value)
                Email = Convert.ToString(row["EMail"]);
            if (DataRecord.HasColumn(row, "MarcaNombre") && row["MarcaNombre"] != DBNull.Value)
                MarcaNombre = Convert.ToString(row["MarcaNombre"]);
        }
    }
}
