using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class GestionFaltantesModel
    {
        public int PaisID { set; get; }
        public int CampaniaID { set; get; }
        public string CUV { set; get; }
        public string Descripcion { set; get; }
        public int ZonaID { set; get; }
        public string Zona { set; get; }
        public IEnumerable<CampaniaModel> listaCampanias { get; set; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public bool FaltanteUltimoMinuto { get; set; }
    }
}