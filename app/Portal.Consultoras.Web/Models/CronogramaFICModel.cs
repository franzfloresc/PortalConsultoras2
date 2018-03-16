using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class CronogramaFICModel
    {
        public int PaisID { set; get; }
        public int ZonaID { set; get; }
        public int CampaniaID { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public List<BECampania> DropDownListCampania { get; set; }
        public string NombreCorto { get; set; }

        public string Zona { get; set; }
        public string CodigoConsultora { get; set; }
        public DateTime FechaFin { get; set; }
        public string Campania { get; set; }
    }
}