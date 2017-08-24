using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaPersonalizadaModel
    {
        public EstrategiaPersonalizadaModel()
        {
            ListaSeccion = new List<ConfiguracionSeccionHomeModel>();
        }
        
        public List<ConfiguracionSeccionHomeModel> ListaSeccion { get; set; }
    }
}