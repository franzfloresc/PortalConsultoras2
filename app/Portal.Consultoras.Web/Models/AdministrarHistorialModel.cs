using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarHistorialModel
    {
        public int IdContenido { set; get; }
        public string Codigo { set; get; }
        public string Descripcion { set; get; }
        public string NombreImagen { set; get; }
        public string NombreImagenAnterior { set; get; }
        public int Estado { set; get; }
        public int DesdeCampania { set; get; }
        public int CantidadContenido { set; get; }
        public string RutaImagen { set; get; }
        public string Ancho { get; set; }
        public string Alto { get; set; }
        public int Campania { set; get; }

        public IEnumerable<CampaniaModel> ListaCampanias { set; get; }
     
       
    }
}