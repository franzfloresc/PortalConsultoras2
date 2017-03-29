﻿using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class EstadoCuentaMobilModel
    {
        public string Simbolo { set; get; }
        public string CorreoConsultora { set; get; }
        public string MontoPagarStr { set; get; }
        public string FechaVencimiento { set; get; }
        public string Glosa { get; set; }
        public string MontoStr { get; set; }
        public List<EstadoCuentaDetalleMobilModel> ListaEstadoCuentaDetalle { get; set; }
    }
}