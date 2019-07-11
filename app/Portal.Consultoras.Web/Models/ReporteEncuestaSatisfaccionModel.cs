using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ReporteEncuestaSatisfaccionModel
    {
        public int PaisID { get; set; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public IEnumerable<CampaniaModel> listaCampanias { set; get; }
        public IEnumerable<RegionModel> listaRegiones { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }

        public int ConsultoraID { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoCampania { set; get; }
        public string Consultora { get; set; }
        public int MotivoID { get; set; }
        public string Calificacion { get; set; }
        public string Motivo { get; set; }

    }
}