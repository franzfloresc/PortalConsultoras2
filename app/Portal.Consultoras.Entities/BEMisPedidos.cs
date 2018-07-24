﻿using Portal.Consultoras.Common;
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
            PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            MarcaID = Convert.ToInt32(row["MarcaID"]);
            Cliente = Convert.ToString(row["NombreCompleto"]);
            Direccion = Convert.ToString(row["Direccion"]);
            Telefono = Convert.ToString(row["Telefono"]);
            Email = Convert.ToString(row["Email"]);
            MensajeDelCliente = Convert.ToString(row["Mensaje"]);
            Estado = Convert.ToString(row["Estado"]);
            FechaSolicitud = Convert.ToDateTime(row["FechaSolicitud"]);
            Campania = row.ToString("Campania");
            Leido = row.ToInt16("Leido");
            NumIteracion = row.ToInt32("NumIteracion");
            CodigoUbigeo = row.ToString("CodigoUbigeo");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            FlagMedio = row.ToString("FlagMedio");
            FlagConsultora = row.ToBoolean("FlagConsultora");
            MedioContacto = row.ToString("MContacto");
            PrecioTotal = row.ToDecimal("PrecioTotal");
            Marca = row.ToString("Marca");
            SaldoHoras = row.ToString("SaldoHoras");
            PedidoWebID = row.ToInt32("PedidoWebID");
            DetallePedido = new List<BEMisPedidosDetalle>();
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
            PedidoDetalleId = Convert.ToInt64(row["SolicitudClienteDetalleID"]);
            PedidoId = Convert.ToInt64(row["SolicitudClienteID"]);
            Producto = Convert.ToString(row["Producto"]);
            Tono = Convert.ToString(row["Tono"]);
            Marca = Convert.ToString(row["Marca"]);
            CUV = Convert.ToString(row["CUV"]);
            PrecioUnitario = Convert.ToDouble(row["Precio"]);
            Cantidad = Convert.ToInt32(row["Cantidad"]);
            PrecioTotal = PrecioUnitario * Cantidad;

            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);

            if (DataRecord.HasColumn(row, "MContacto"))
                MedioContacto = Convert.ToString(row["MContacto"]);

            if (DataRecord.HasColumn(row, "TipoAtencion"))
                TipoAtencion = Convert.ToInt32(row["TipoAtencion"]);

            if (DataRecord.HasColumn(row, "PedidoWebID"))
                PedidoWebID = Convert.ToInt32(row["PedidoWebID"]);

            if (DataRecord.HasColumn(row, "PedidoWebDetalleID"))
                PedidoWebDetalleID = Convert.ToInt32(row["PedidoWebDetalleID"]);
        }
    }
}
