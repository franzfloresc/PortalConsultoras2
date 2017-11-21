﻿using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class NotificacionesModel
    {
        public string NombreConsultora { get; set; }
        public string DescripcionRechazo { get; set; }
        public string Campania { get; set; }
        public string CampaniaDescripcion { get; set; }
        public DateTime FechaValidacion { get; set; }
        public string FechaValidacionString { get; set; }
        public List<BENotificaciones> ListaNotificaciones { get; set; }
        public List<BENotificacionesDetalle> ListaNotificacionesDetalle { get; set; }
        public List<NotificacionesModelDetallePedido> ListaNotificacionesDetallePedido { get; set; }
        public BENotificacionesDetalleCatalogo NotificacionDetalleCatalogo { get; set; }
        //RQ_NS - R2133
        public int Origen { get; set; }
        /*R20150802 - Catalogo*/
        public bool TieneDescuentoCuv { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Descuento { get; set; }
        public decimal Total { get; set; }
        public string SubTotalString { get; set; }
        public string DescuentoString { get; set; }
        public string TotalString { get; set; }
        public Converter<decimal, string> DecimalToString { get; set; }
        public string MotivoRechazo { get; set; }

        /*EPD-1912*/
        public string CuerpoMensaje1 { get; set; }
        public List<string> CuerpoDetalles { get; set; }
        public string CuerpoMensaje2 { get; set; }
        /*HD-732*/
        public string simbolo { get; set; }
        public string mGanancia { get; set; }
    }
}