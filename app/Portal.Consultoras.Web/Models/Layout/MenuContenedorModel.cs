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
        public string CampaniaX0ConFormato
        {
            get
            {
                return (CampaniaX0 % 100).ToString("00");
            }
        }
        public string CampaniaX1ConFormato
        {
            get
            {
                return (CampaniaX1 % 100).ToString("00");
            }
        }
        public ConfiguracionPaisModel ConfiguracionPais { get; set; }
    }
}