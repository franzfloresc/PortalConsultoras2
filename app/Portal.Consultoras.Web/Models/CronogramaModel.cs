using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class CronogramaModel
    {
        public int CampaniaID { get; set; }

        public int ZonaID { get; set; }

        public Int16 TipoCronogramaID { get; set; }

        public DateTime FechaInicioWeb { get; set; }

        public DateTime FechaFinWeb { get; set; }

        public DateTime FechaInicioDD { get; set; }

        public DateTime FechaFinDD { get; set; }

        public int PaisID { get; set; }

        public string ZonaNombre { get; set; }

        public string CodigoZona { get; set; }

        public string CodigoCampania { get; set; }

        public IEnumerable<CampaniaModel> listaCampania { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public IEnumerable<ZonaModel> listaZonas { get; set; }
    }
}