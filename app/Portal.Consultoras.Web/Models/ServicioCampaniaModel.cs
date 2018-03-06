using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ServicioCampaniaModel
    {
        public int ServicioId { get; set; }

        public string Descripcion { get; set; }

        public string Url { get; set; }
    }
}