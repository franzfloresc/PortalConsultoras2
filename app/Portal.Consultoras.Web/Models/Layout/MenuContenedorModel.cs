using System;

namespace Portal.Consultoras.Web.Models.Layout
{
    [Serializable]
    public class MenuContenedorModel
    {
        public string Codigo { get; set; }
        public int CampaniaId { get; set; }
        public int CampaniaX0 { get; set; }
        public int CampaniaX1 { get; set; }
        public ConfiguracionPaisModel ConfiguracionPais { get; set; }
    }
}