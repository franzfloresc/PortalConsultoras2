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
            this.PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);

            this.ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            this.ConsultoraCodigo = Convert.ToString(row["ConsultoraCodigo"]);
            this.ConsultoraNombre = Convert.ToString(row["ConsultoraNombre"]);
            this.ConsultoraCorreo = Convert.ToString(row["ConsultoraCorreo"]);
            this.ConsultoraCelular = Convert.ToString(row["ConsultoraCelular"]);

            if (DataRecord.HasColumn(row, "Campania"))
                this.Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "Leido"))
                this.Leido = Convert.ToInt16(row["Leido"]);

            this.MarcaID = Convert.ToInt32(row["MarcaID"]);
            this.Marca = Convert.ToString(row["Marca"]);

            if (DataRecord.HasColumn(row, "TipoUsuario"))
                this.TipoUsuario = Convert.ToInt32(row["TipoUsuario"]);

            if (DataRecord.HasColumn(row, "FlagConsultora"))
                this.FlagConsultora = Convert.ToBoolean(row["FlagConsultora"]);

            this.FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            this.Estado = Convert.ToString(row["Estado"]);

            this.ClienteNombre = Convert.ToString(row["ClienteNombre"]);
            this.ClienteTelefono = Convert.ToString(row["ClienteTelefono"]);
            this.ClienteEmail = Convert.ToString(row["ClienteEmail"]);
            this.ClienteDireccion = Convert.ToString(row["ClienteDireccion"]);
            this.Mensaje = Convert.ToString(row["Mensaje"]);

            if (DataRecord.HasColumn(row, "Total"))
                this.Total = Convert.ToDecimal(row["Total"]);

            this.Cantidad = Convert.ToInt32(row["Cantidad"]);

            this.DetallePedido = new List<BEMisPedidosDetalleAppCatalogo>();
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
            if (DataRecord.HasColumn(row, "Error"))
                Error = Convert.ToBoolean(row["Error"]);
            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);
        }

        public BEResultadoMisPedidosAppCatalogo(Boolean error, string mensaje)
        {
            this.Error = error;
            this.Mensaje = mensaje;
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
            this.PedidoDetalleId = Convert.ToInt64(row["SolicitudClienteDetalleID"]);
            this.PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            this.Producto = Convert.ToString(row["Producto"]);
            this.Tono = Convert.ToString(row["Tono"]);
            this.Marca = Convert.ToString(row["Marca"]);
            this.CUV = Convert.ToString(row["CUV"]);
            this.PrecioUnitario = Convert.ToDouble(row["Precio"]);
            this.Cantidad = Convert.ToInt32(row["Cantidad"]);
            this.SubTotal = this.PrecioUnitario * this.Cantidad;
            this.Url = Convert.ToString(row["Url"]);
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
            if (DataRecord.HasColumn(row, "Error"))
                Error = Convert.ToBoolean(row["Error"]);
            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);
        }

        public BEResultadoPedidoDetalleAppCatalogo(Boolean error, string mensaje)
        {
            this.Error = error;
            this.Mensaje = mensaje;
        }
    }
}
