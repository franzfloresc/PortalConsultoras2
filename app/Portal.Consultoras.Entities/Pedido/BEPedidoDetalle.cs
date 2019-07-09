﻿using Portal.Consultoras.Entities.ReservaProl;
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoDetalle : ICloneable 
    {
        public BEPedidoDetalle()
        {
            Producto = new BEProducto();
            Usuario = new BEUsuario();
            Estrategia = new BEEstrategia();
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public BEProducto Producto { get; set; }
        [DataMember]
        public string IPUsuario { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public short ClienteID { get; set; }
        [DataMember]
        public string ClienteDescripcion { get; set; }
        [DataMember]
        public string Identifier { get; set; }
        [DataMember]
        public bool EsKitNueva { get; set; }
        [DataMember]
        public BEUsuario Usuario { get; set; }
        [DataMember]
        public short PedidoDetalleID { get; set; }
        [DataMember]
        public string ObservacionPROL { get; set; }
        [DataMember]
        public int OrigenPedidoWeb { get; set; }
        [DataMember]
        public int SetID { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public bool EsSugerido { get; set; }
        [DataMember]
        public int LimiteVenta { get; set; }
        [DataMember]
        public string TipoPersonalizacion { get; set; }
        [DataMember]
        public bool EsVirtualCoach { get; set; }
        [DataMember]
        public bool EsCuponNuevas { get; set; }
        [DataMember]
        public BEEstrategia Estrategia { get; set; }
        [DataMember]
        public int StockNuevo { get; set; }
        [DataMember]
        public bool EsKitNuevaAuto { get; set; }
        [DataMember]
        public bool OfertaWeb { get; set; }
        [DataMember]
        public bool EsEditable { get; set; }
        [DataMember]
        public string OrigenSolicitud { get; set; }
        [DataMember]
        public bool EsDuoPerfecto { get; set; }
        [DataMember]
        public BEInputReservaProl ReservaProl { get; set; }
        [DataMember]
        public string IngresoExternoOrigen { get; set; }
        [DataMember]
        public List<BEPedidoWebPromocion> PedidoWebPromociones { get; set; }

        public bool Reservado { get; set; }
        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}
