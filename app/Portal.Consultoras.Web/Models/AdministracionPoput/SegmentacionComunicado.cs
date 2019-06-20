using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.AdministracionPoput
{
    public class SegmentacionComunicadoModel
    {
        public int SegmentacionComunicadoId { get; set; }
        public int SegmentacionID { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoRegion { get; set; }
        public string CodigoZona { get; set; }
        public int IdEstadoActividad { get; set; }
    }
}