﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class NotificacionesMobileModel
    {

        public string NombreConsultora { get; set; }
        public List<BENotificaciones> ListaNotificaciones { get; set; }
        public List<BENotificacionesDetalle> ListaNotificacionesDetalle { get; set; }
        public List<BENotificacionesDetallePedido> ListaNotificacionesDetallePedido { get; set; }
        //RQ_NS - R2133
        public int Origen { get; set; }
        public string Observaciones {get; set; }
        public int estado { get; set; }
        public bool FacturaHoy { get; set; }
        public DateTime FechaFacturacion { get; set; }
        public int Campania { get; set; }
        public string Asunto { get; set; }
    }
}