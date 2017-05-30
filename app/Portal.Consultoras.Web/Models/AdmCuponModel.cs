using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdmCuponModel
    {
        public IEnumerable<PaisModel> ListaPaises { set; get; }
        public IEnumerable<CampaniaModel> ListaCampanias { set; get; }
        public int PaisID { get; set; }
        public int CampaniaID { get; set; }
    }
}