using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class AdministrarMontoExigenciaModel
    {
        public int PaisID { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public int CampaniaID { get; set; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
    }
}