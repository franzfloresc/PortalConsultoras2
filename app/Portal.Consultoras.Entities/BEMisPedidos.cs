using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMisPedidos
    {
        [DataMember]
        public long PedidoId { get; set; }
        [DataMember]
        public string Cliente { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string MensajeDelCliente { get; set; }
        [DataMember]
        public int Leido { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public int NumIteracion { get; set; }
        [DataMember]
        public string CodigoUbigeo { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public DateTime FechaSolicitud { get; set; }
        [DataMember]
        public DateTime? FechaModificacion { get; set; }
        [DataMember]
        public string FlagMedio { get; set; }
        [DataMember]
        public bool FlagConsultora { get; set; }

        [DataMember]
        public string MedioContacto { get; set; }

        [DataMember]
        public decimal PrecioTotal { get; set; }

        [DataMember]
        public string Marca { get; set; }

        [DataMember]
        public string SaldoHoras { get; set; }

        [DataMember]
        public string FormartoFechaSolicitud { get; set; }

        [DataMember]
        public string FormatoPrecioTotal { get; set; }

        [DataMember]
        public int PedidoWebID { get; set; }

        [DataMember]
        public List<BEMisPedidosDetalle> DetallePedido { get; set; }

        public BEMisPedidos(IDataRecord row)
        {
            this.PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            this.MarcaID = Convert.ToInt32(row["MarcaID"]);
            this.Cliente = Convert.ToString(row["NombreCompleto"]);
            this.Direccion = Convert.ToString(row["Direccion"]);
            this.Telefono = Convert.ToString(row["Telefono"]);
            this.Email = Convert.ToString(row["Email"]);
            this.MensajeDelCliente = Convert.ToString(row["Mensaje"]);
            this.Estado = Convert.ToString(row["Estado"]);
            this.FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);

            if (DataRecord.HasColumn(row, "Campania"))
                this.Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "Leido"))
                this.Leido = Convert.ToInt16(row["Leido"]);
            if (DataRecord.HasColumn(row, "NumIteracion"))
                this.NumIteracion = Convert.ToInt32(row["NumIteracion"]);
            if (DataRecord.HasColumn(row, "CodigoUbigeo"))
                this.CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);

            if (DataRecord.HasColumn(row, "FechaModificacion"))
                this.FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "FlagMedio"))
                this.FlagMedio = Convert.ToString(row["FlagMedio"]);
            if (DataRecord.HasColumn(row, "FlagConsultora"))
                this.FlagConsultora = Convert.ToBoolean(row["FlagConsultora"]);

            if (DataRecord.HasColumn(row, "MContacto"))
                this.MedioContacto = Convert.ToString(row["MContacto"]);
            if (DataRecord.HasColumn(row, "PrecioTotal"))
                this.PrecioTotal = Convert.ToDecimal(row["PrecioTotal"]);
            if (DataRecord.HasColumn(row, "Marca"))
                this.Marca = Convert.ToString(row["Marca"]);

            if (DataRecord.HasColumn(row, "SaldoHoras"))
                this.SaldoHoras = Convert.ToString(row["SaldoHoras"]);

            if (DataRecord.HasColumn(row, "PedidoWebID"))
                this.PedidoWebID = Convert.ToInt32(row["PedidoWebID"]);


            this.DetallePedido = new List<BEMisPedidosDetalle>();
        }
    }

    [DataContract]
    public class BEMisPedidosDetalle
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
        public int Cantidad { get; set; }
        [DataMember]
        public double PrecioUnitario { get; set; }
        [DataMember]
        public double PrecioTotal { get; set; }

        [DataMember]
        public string MedioContacto { get; set; }
        [DataMember]
        public int EstaEnRevista { get; set; }
        [DataMember]
        public int TieneStock { get; set; }
        [DataMember]
        public string MensajeValidacion { get; set; }

        [DataMember]
        public int TipoAtencion { get; set; }

        [DataMember]
        public int PedidoWebID { get; set; }

        [DataMember]
        public int PedidoWebDetalleID { get; set; }

        public BEMisPedidosDetalle()
        {
        }

        public BEMisPedidosDetalle(IDataRecord row)
        {
            this.PedidoDetalleId = Convert.ToInt64(row["SolicitudClienteDetalleID"]);
            this.PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            this.Producto = Convert.ToString(row["Producto"]);
            this.Tono = Convert.ToString(row["Tono"]);
            this.Marca = Convert.ToString(row["Marca"]);
            this.CUV = Convert.ToString(row["CUV"]);
            this.PrecioUnitario = Convert.ToDouble(row["Precio"]);
            this.Cantidad = Convert.ToInt32(row["Cantidad"]);
            this.PrecioTotal = this.PrecioUnitario * this.Cantidad;

            if (DataRecord.HasColumn(row, "MarcaID"))
                this.MarcaID = Convert.ToInt32(row["MarcaID"]);

            if (DataRecord.HasColumn(row, "MContacto"))
                this.MedioContacto = Convert.ToString(row["MContacto"]);

            if (DataRecord.HasColumn(row, "TipoAtencion"))
                this.TipoAtencion = Convert.ToInt32(row["TipoAtencion"]);

            if (DataRecord.HasColumn(row, "PedidoWebID"))
                this.PedidoWebID = Convert.ToInt32(row["PedidoWebID"]);

            if (DataRecord.HasColumn(row, "PedidoWebDetalleID"))
                this.PedidoWebDetalleID = Convert.ToInt32(row["PedidoWebDetalleID"]);
        }
    }
}
