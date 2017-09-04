using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaFICModel
    {
        public int PaisID { get; set; }
        public int CampaniaID { set; get; }
        public string CUV { get; set; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public IEnumerable<CampaniaModel> listaCampanias { set; get; }
    }
}