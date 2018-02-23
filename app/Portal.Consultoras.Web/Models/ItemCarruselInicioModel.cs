using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class BienvenidosModel
    {
        public List<ItemCarruselInicioModel> ItemsCarruselInicio { get; set; }
        public ActualizarDatosModel ActualizarDatos { get; set; }

        public BienvenidosModel()
        {
            ItemsCarruselInicio = new List<ItemCarruselInicioModel>();
            ActualizarDatos = new ActualizarDatosModel();
        }
    }

    public class ItemCarruselInicioModel
    {
        public int ItemCarruselInicioID { get; set; }

        public string UrlImagenPrincipal { get; set; }

        public string UrlImagenTitulo { get; set; }

        public string TextoDescripcion { get; set; }

        public string TextoLink { get; set; }

        public string UrlLink { get; set; }

        public bool EsVideo { get; set; }

        public string UrlLinkPrincipal { get; set; }

        public bool UrlLinkPrincipalExterno { get; set; }

        public string TextoDescripcion2 { get; set; }

        public int Orden { get; set; }

        public string NombreItem { get; set; }
    }
}