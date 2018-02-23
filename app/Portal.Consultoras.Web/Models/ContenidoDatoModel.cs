using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ContenidoDatoModel
    {
        public int CampaniaID { get; set; }
        public int PaisID { get; set; }
        public int FlagTransaccion { get; set; }
        public string ImagenFondo { get; set; }
        public string ImagenLogo { get; set; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public IEnumerable<CampaniaModel> listaCampanias { set; get; }
    }
}