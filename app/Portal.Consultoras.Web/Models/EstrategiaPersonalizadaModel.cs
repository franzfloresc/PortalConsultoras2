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

        public MensajeProductoBloqueadoModel MensajeProductoBloqueado { get; set; }
        public MensajeProductoBloqueadoModel MensajeProductoBloqueado2 { get; set; }
        public List<ConfiguracionSeccionHomeModel> ListaSeccion { get; set; }
        public int vc_sinProducto2 { get; set; }
    }
}