using Portal.Consultoras.Web.ServiceContenido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class NavidadConsultoraModel
    {
        public int CampaniaId { get; set; }
        public int PaisId { get; set; }
        public string UrlImagen { get; set; }
        public int ImagenId { get; set; }
        public string UrlComparte { get; set; }
        public IEnumerable<CampaniaModel> ListaCampania { get; set; }
        public IEnumerable<PaisModel> ListaPaises { get; set; }
        public List<BENavidadConsultora> ListaImagenNavidadConsultora { get; set; }
    }
}