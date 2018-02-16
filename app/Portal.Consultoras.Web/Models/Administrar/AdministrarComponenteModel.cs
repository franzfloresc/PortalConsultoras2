using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarComponenteModel
    {
        public string ConfiguracionPaisComponenteID { get; set; }
        public int CampaniaID { get; set; }
        public string Componente { get; set; }
        public int PalancaID { get; set; }
        public IEnumerable<CampaniaModel> ListaCampanias { set; get; }
        public IEnumerable<ConfiguracionPaisComponenteModel> ListaCompomente { set; get; }
        public IEnumerable<ConfiguracionPaisModel> ListaPalanca { set; get; }

        public List<AdministrarComponenteDatosModel> ListaDatos { get; set; }
    }
}