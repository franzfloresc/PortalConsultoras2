using System;

namespace Portal.Consultoras.Web.Models.Layout
{
    [Serializable]
    public class MenuContenedorModel
    {
        public string Codigo { get; set; }
        public int CampaniaID { get; set; }
        public string Logo { get; set; }
        public string TituloMenu { get; set; }
        public string SubTituloMenu { get; set; }
        public int Orden { get; set; }

        public string LogoBanner { get; set; }
        public string FondoBanner { get; set; }
        public string TituloBanner { get; set; }
        public string SubTituloBanner { get; set; }
        public string UrlMenu { get; set; }

        public bool IsMenuCampania { get; set; }
        public bool Activa { get; set; }
        public bool EsAncla { get; set; }

        // Solo para Menu Campaña
        public int CampaniaX0 { get; set; }
        public int CampaniaX1 { get; set; }
    }
}