using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Models
{
    public class NotificacionesModel
    {
        public string NombreConsultora { get; set; }
        public List<BENotificaciones> ListaNotificaciones { get; set; }
        public List<BENotificacionesDetalle> ListaNotificacionesDetalle { get; set; }
        public List<BENotificacionesDetallePedido> ListaNotificacionesDetallePedido { get; set; }
        //RQ_NS - R2133
        public int Origen { get; set; }
        /*R20150802 - Catalogo*/
        public BENotificacionesDetalleCatalogo NotificacionDetalleCatalogo { get; set; }
    }
}